//
//  TickerModelTests.swift
//  BitfinexMonitorTests
//
//  Created by Paolo Musolino on 13/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import XCTest
@testable import BitfinexMonitor

class TickerModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitWithNoNestedArray() {
        let data: [Any] = [1.11, 5.55234324, 4.5]
        let ticker = try? TickerModel(array: data)
        
        if ticker != nil{
            XCTFail("Ticker was initialized also with no nester array")
        }
    }
    
    func testInitWithMoreThan10Params(){
        let data: [Any] = [1 as Int, [3.332, 4.41341, 322323.3232, 21315.6892, 53.321312, 3213232321.11, 2323.2, 3232.3, 2323.1, 332.2, 453.1]]
        let ticker = try? TickerModel(array: data)
        
        if ticker != nil{
            XCTFail("Ticker was initialized with more than 3 params")
        }
    }
    
    func testInitWithCorrectData(){
        let data: [Any] = [1 as Int, [3.332, 4.41341, 322323.3232, 21315.6892, 53.321312, 3213232321.11, 2323.2, 3232.3, 2323.1, 332.2]]
        let ticker = try? TickerModel(array: data)
        if ticker == nil{
            XCTFail("Ticker was not initialized correctly")
        }
    }
    
    func testInitWithWrongDataType(){
        let data: [Any] = [1 as Int, ["This", 4.5, "test"]]
        let ticker = try? TickerModel(array: data)
        
        if ticker != nil{
            XCTFail("Ticker was initialized with wrong data type")
        }
    }
    
}
