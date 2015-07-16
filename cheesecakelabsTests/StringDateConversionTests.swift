//
//  StringDateConversionTests.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/16/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import XCTest
@testable import cheesecakelabs

class StringDateConversionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetNSDateFromStringNotNil() {
        let date = StringDateConversion.getNSDate("05/26/2014")
        XCTAssertNotNil(date)
    }
    
    func testGetStringFromNSDateNotNil() {
        let date = StringDateConversion.getNSDate("05/26/2014")
        let dateString = StringDateConversion.getBRString(date!)
        XCTAssertNotNil(dateString)
    }
    
    func testGetStringFromNSDateMatchesBRFormat() {
        let date = StringDateConversion.getNSDate("05/26/2014")
        let dateString = StringDateConversion.getBRString(date!)
        XCTAssertEqual(String(dateString!), "26/05/2014")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
