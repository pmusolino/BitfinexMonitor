//
//  TickerModel.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import Foundation

struct TickerModel: Codable {
    
    var bid: Double? // Price of last highest bid
    var bid_size: Double? //Size of the last highest bid
    var ask: Double? // Price of last lowest ask
    var ask_size: Double? //Size of the last lowest ask
    var daily_change: Double? //Amount that the last price has changed since yesterday
    var daily_change_perc: Double? //Amount that the price has changed expressed in percentage terms
    var last_price: Double? //Price of the last trade.
    var volume: Double? //Daily volume
    var high: Double? //Daily high
    var low: Double? //Daily low
    
    init(array: [Any]) throws{
        if array.count == 2 && (array[1] is [Any]) == true{
            if let nestedArray = array[1] as? [Any]{
                if nestedArray.count == 10{
                    if let bidA = nestedArray[0] as? Double, let bid_sizeA = nestedArray[1] as? Double, let askA = nestedArray[2] as? Double, let ask_sizeA = nestedArray[3] as? Double, let daily_changeA = nestedArray[4] as? Double, let daily_change_percA = nestedArray[5] as? Double, let last_priceA = nestedArray[6] as? Double, let volumeA = nestedArray[7] as? Double, let highA = nestedArray[8] as? Double, let lowA = nestedArray[9] as? Double{
                        bid = bidA
                        bid_size = bid_sizeA
                        ask = askA
                        ask_size = ask_sizeA
                        daily_change = daily_changeA
                        daily_change_perc = daily_change_percA
                        last_price = last_priceA
                        volume = volumeA
                        high = highA
                        low = lowA
                        return
                    }
                }
            }
        }
        throw CodableErrors.InitError
    }
}
