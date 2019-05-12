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
    @IBOutlet weak var ordersSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    private var buyOrders: [OrderBookModel] = []
    private var sellOrders: [OrderBookModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle:nil), forCellReuseIdentifier: "OrderTableViewCell")
        
        SocketEngine.shared.connect()
        
        SocketEngine.shared.newOrder { [weak self] (order) in
            self?.populateOrders(order)
        }
        
        SocketEngine.shared.newTicker { [weak self] (ticker) in
            self?.populateTickerSection(ticker)
        }
    }
    
    
    
    func populateTickerSection(_ ticker: TickerModel){
        
        if let price = ticker.last_price{
            priceLabel.text = String(format: "$%.2f", price)
        }
        
        if let daily_change = ticker.daily_change_perc{
        dailyChangeLabel.textColor = daily_change.isLess(than: 0.0) ? Colors.UI.red : Colors.UI.green
        dailyChangeLabel.text = "%" + String(format: "%.2f", daily_change)
        }
        
        if let volume = ticker.volume, let high = ticker.high, let low = ticker.low{
            volumeLabel.text = String(format: "%.3f", volume)
            highLabel.text = String(format: "$%.2f", high)
            lowLabel.text = String(format: "$%.2f", low)
        }
    }
    
    func populateOrders(_ order: OrderBookModel){
        // Total amount available at that price level.
        // Positive values mean bid, negative values mean ask.
        if let amount = order.amount{
            if amount.isLess(than: 0.0){
                sellOrders.insert(order, at: 0)
            }
            else{
                buyOrders.insert(order, at: 0)
            }
            
            tableView.reloadData()
            tableViewHeightConstraint.constant = tableView.contentSize.height
        }
    }


    //MARK: - Actions
    @IBAction func segmentedControlTapped(_ sender: UISegmentedControl) {
        tableView.reloadData()
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ordersSegmentedControl.selectedSegmentIndex {
        case 0:
            return buyOrders.count > 25 ? 25 : buyOrders.count
        case 1:
            return sellOrders.count > 25 ? 25 : sellOrders.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        switch ordersSegmentedControl.selectedSegmentIndex {
        case 0:
            cell.populate(order: buyOrders[indexPath.row])
            break
        case 1:
            cell.populate(order: sellOrders[indexPath.row])
        default:
            break
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
}
