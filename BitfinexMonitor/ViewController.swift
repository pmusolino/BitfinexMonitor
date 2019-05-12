//
//  ViewController.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dailyChangeLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketEngine.shared.connect()
        
        SocketEngine.shared.newOrder { (order) in
        }
        
        SocketEngine.shared.newTicker { [weak self] (ticker) in
            self?.populateTickerSection(ticker)
        }
    }
    
    
    
    func populateTickerSection(_ ticker: TickerModel?){
        guard ticker != nil else {
            return
        }
        if let price = ticker?.last_price{
            priceLabel.text = String(format: "$%.2f", price)
        }
        
        if let daily_change = ticker?.daily_change_perc{
        dailyChangeLabel.textColor = daily_change.isLess(than: 0.0) ? Colors.UI.red : Colors.UI.green
        dailyChangeLabel.text = "%" + String(format: "%.2f", daily_change)
        }
        
        if let volume = ticker?.volume, let high = ticker?.high, let low = ticker?.low{
            volumeLabel.text = String(format: "%.3f", volume)
            highLabel.text = String(format: "$%.2f", high)
            lowLabel.text = String(format: "$%.2f", low)
        }
    }


}
