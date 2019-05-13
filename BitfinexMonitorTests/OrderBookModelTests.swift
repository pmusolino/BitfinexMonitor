//
//  OrderBookModelTests.swift
//  BitfinexMonitorTests
//
//  Created by Paolo Musolino on 13/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import XCTest
@testable import BitfinexMonitor

class OrderBookModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitWithNoNestedArray() {
        let data: [Any] = [1.11, 3 as Int, 4.5]
        let order = try? OrderBookModel(array: data)
        
        if order != nil{
            XCTFail("Order was initialized also with no nester array")
        }
    }
    
    func testInitWithMoreThan3Params(){
        let data: [Any] = [1 as Int, [3.332, 4 as Int, 322323.3232, 21315.6892, 53.321312]]
        let order = try? OrderBookModel(array: data)
        
        if order != nil{
            XCTFail("Order was initialized with more than 3 params")
        }
    }
    
    func testInitWithCorrectData(){
        let data: [Any] = [1 as Int, [3.542342314213, 4 as Int, 322323.3232]]
        let order = try? OrderBookModel(array: data)
        if order == nil{
            XCTFail("Order was not initialized correctly")
        }
    }
    
    func testInitWithWrongDataType(){
        let data: [Any] = [1 as Int, ["This", 4.5, "test"]]
        let order = try? OrderBookModel(array: data)
        
        if order != nil{
            XCTFail("Order was initialized with wrong data type")
        }
    }
    
}
