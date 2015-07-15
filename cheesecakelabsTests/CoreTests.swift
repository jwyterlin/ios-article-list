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
        CORE.setManagedContext(setUpInMemoryManagedObjectContext()!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testManagedContextNotNil() {
        XCTAssertNotNil(CORE.managedContext)
    }
    
    func testCreateData() {
        mockApi.setFullArticles()
        let articleArray = mockApi.getArticlesForCoreData()
        XCTAssertTrue(CORE.createData(articleArray))        
    }

    func testRetriveData() {
        mockApi.setFullArticles()
        let articleArray = mockApi.getArticlesForCoreData()
        CORE.createData(articleArray)
        print(CORE.retriveData("website")!.count)
        XCTAssertTrue(CORE.retriveData("website")!.count > 0)
    }
    
    func testDeleteData() {
        mockApi.setFullArticles()
        let articleArray = mockApi.getArticlesForCoreData()
        CORE.createData(articleArray)
        var article = CORE.retriveData("website")
        CORE.deleteData((article?.first)!)
        CORE.deleteData((article?.last)!)
        XCTAssertTrue(CORE.retriveData("website")!.count == 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
