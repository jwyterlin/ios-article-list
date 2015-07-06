//
//  SortTableViewCtrl.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/6/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import XCTest
@testable import cheesecakelabs

class SortTableViewCtrlTests: XCTestCase {

    var sortTableViewCtrl: SortTableViewCtrl?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sortTableViewCtrl = storyboard.instantiateViewControllerWithIdentifier("SortTableViewCtrl") as?SortTableViewCtrl
        sortTableViewCtrl?.viewDidLoad()
        sortTableViewCtrl!.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testSortTableViewCtrlNotNil() {
        XCTAssertNotNil(sortTableViewCtrl, "sortTableView is nil")
    }
    
    func testClientsStoryBoard(){
        XCTAssertNotNil(sortTableViewCtrl!.sortTableView,"Not Nil")
    }
    
    func testNumbersOfRowsInSortTableView() {
        XCTAssertEqual(sortTableViewCtrl!.sortTableView.numberOfRowsInSection(0), 4, "Wrong number or rows in articles tableview")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    

}
