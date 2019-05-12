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
                    bid = nestedArray[0] as? Double
                    bid_size = nestedArray[1] as? Double
                    ask = nestedArray[2] as? Double
                    ask_size = nestedArray[3] as? Double
                    daily_change = nestedArray[4] as? Double
                    daily_change_perc = nestedArray[5] as? Double
                    last_price = nestedArray[6] as? Double
                    volume = nestedArray[7] as? Double
                    high = nestedArray[8] as? Double
                    low = nestedArray[9] as? Double
                }
            }
        }
        else{
            throw CodableErrors.InitError
        }
    }
}
