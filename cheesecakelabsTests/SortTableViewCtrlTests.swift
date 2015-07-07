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
        sortTableViewCtrl = nil
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
    
    func testSortOptionsArrayLenght() {
        XCTAssertEqual(sortTableViewCtrl!.options.count, 4, "Sort options array doesn't have the right number os options")
    }
    
    func testSortOptionsArrayItems() {
        let options: NSArray = NSArray(array: ["Title", "Date", "Authors", "Website"])
        for var index = 0; index < options.count; ++index {
            XCTAssertEqual(sortTableViewCtrl!.options[index] as! String, options[index] as! String, "Sort option doesn't not match the requeriments")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    

}
