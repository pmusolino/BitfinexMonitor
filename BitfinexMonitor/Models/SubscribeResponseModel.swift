//
//  SubscribeResponseModel.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import Foundation

struct SubscribeResponseModel: Codable {
    
    var event: Event?
    var channel: Channel?
    var chanId: Int?
    var symbol: String?
    var pair: String?

}
