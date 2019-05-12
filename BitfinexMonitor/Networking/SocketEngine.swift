//
//  SocketEngine.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import UIKit
import Starscream

/*
 / Each message sent and received via the Bitfinex's websocket channel is encoded in JSON format
 / Websocket documentation: https://docs.bitfinex.com/v2/docs/ws-general
 */

class SocketEngine: NSObject {
    
    static let shared = SocketEngine() //Socket client manager
    
    private var socket = WebSocket(url: URL(string: "wss://api-pub.bitfinex.com/ws/2")!)
    private var bookChanId: Int = -1
    private var tickerChanId: Int = -1
    private var newOrderCallback: ((OrderBookModel) -> ())?
    private var newTickerCallback: ((TickerModel) -> ())?
    
    override init() {
        super.init()
        socket.delegate = self
    }
    
    func connect(){
        socket.connect()
    }
    
    func newOrder(result: @escaping ((OrderBookModel) -> Void)){
        newOrderCallback = result
    }
    
    func newTicker(result: @escaping ((TickerModel) -> Void)){
        newTickerCallback = result
    }
    
    private func subscribeToBitfinexChannels(){
        if let book = SubscribeRequestModel(channel: .book).toJSONData(){
            socket.write(data: book)
        }
        if let ticker = SubscribeRequestModel(channel: .ticker).toJSONData(){
            socket.write(data: ticker)
        }
    }
    
}

extension SocketEngine: WebSocketDelegate{
    func websocketDidConnect(socket: WebSocketClient) {
        print("Websocket is connected")
        subscribeToBitfinexChannels()
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("Websocket is disconnected:", error?.localizedDescription ?? "unknown error")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        //print("Websocket message", text)
        
        //For optimization reasons, i check if the json sent from Bitfinex it's a dictionary or an array. If the text received start and close { } i'll try to parse it into a SubscribeResponseModel (expensive if done for every message received), else i'll try to parse it in OrderBookModel or TickerModel.
        if text.first == "{" && text.last == "}"{
            if let subscribeResponse = try? SubscribeResponseModel(from: text){
                if subscribeResponse.event == .subscribed{
                    if subscribeResponse.channel == .book{
                        bookChanId = subscribeResponse.chanId ?? -1
                    }
                    else if subscribeResponse.channel == .ticker{
                        tickerChanId = subscribeResponse.chanId ?? -1
                    }
                    return
                }
            }
        }
        if text.first == "[" && text.last == "]"{
            if let data = text.data(using: .utf8){
                if let array = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]{
                    
                    //Channel check and model parse
                    if (array.first as? Int) == bookChanId{
                        if let order = try? OrderBookModel(array: array){
                            newOrderCallback?(order)
                        }
                    }
                    else if (array.first as? Int) == tickerChanId{
                        if let ticker = try? TickerModel(array: array){
                            newTickerCallback?(ticker)
                        }
                    }
                }
            }
        }
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        //print("Websocket data", String(data: data, encoding: .utf8) ?? "no parsable data")
    }
}
