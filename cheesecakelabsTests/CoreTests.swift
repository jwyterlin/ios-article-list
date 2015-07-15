//
//  Core.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/7/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import XCTest
import CoreData

@testable import cheesecakelabs

class CoreTests: XCTestCase {

    let CORE = Core()
    let mockApi = MockApi.sharedInstance

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testManagedContextNotNil() {
        CORE.setManagedContext(setUpInMemoryManagedObjectContext()!)
        XCTAssertNotNil(CORE.managedContext)
    }
    
    func testCreateData() {
        
        var article = getArticlesMock()
        let articleArray = NSMutableArray()
        articleArray.addObject(article)
        CORE.createData(articleArray)
        
    }

    func testRetriveData() {
        
    }
    
    func testUpdateData() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
