//
//  OrderBookModel.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import Foundation

struct OrderBookModel: Codable {
    
    var price: Double? //Price level.
    var count: Int? //Number of orders at that price level.
    var amount: Double? //Total amount available at that price level. Positive values mean bid, negative values mean ask.
    
    init(array: [Any]) throws {
        if array.count == 2 && (array[1] is [Any]) == true{
            if let nestedArray = array[1] as? [Any]{
                if nestedArray.count == 3{
                    price = nestedArray[0] as? Double
                    count = nestedArray[1] as? Int
                    amount = nestedArray[2] as? Double
                }
            }
        }
        else{
            throw CodableErrors.InitError
        }
    }
}
