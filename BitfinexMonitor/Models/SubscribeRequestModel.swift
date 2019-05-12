//
//  SubscribeRequestModel.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import Foundation

struct SubscribeRequestModel: Codable {
    
    var event: Event = .subscribe
    var channel: Channel?
    var pair: String = "btcusd"
    
    init(channel: Channel) {
        self.channel = channel
    }
    
}

enum Channel: String, Codable {
    case ticker = "ticker"
    case book = "book"
}

enum Event: String, Codable{
    case info = "info"
    case subscribe = "subscribe"
    case subscribed = "subscribed"
}
