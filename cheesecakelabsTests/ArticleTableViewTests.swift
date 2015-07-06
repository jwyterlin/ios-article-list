//
//  cklTests.swift
//  cklTests
//
//  Created by Israel Tavares on 7/4/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import UIKit
import XCTest
@testable import cheesecakelabs

class ArticleTableviewTests: XCTestCase {
    
    var articleTableview = ArticleTableview(frame: CGRectZero, style: .Plain)
    var mockAPI = MockApi.sharedInstance
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testArticleTableViewNotNil() {
        XCTAssertNotNil(articleTableview,"articleTableView is nil")
    }
    
    func testArticleTableViewDataSource() {
        XCTAssertNotNil(articleTableview.dataSource,"articleTableView dataSource is nil")
    }
    
    func testArticleTableviewDelegateSet() {
        XCTAssertNotNil(articleTableview.delegate,"articleTableView dataSource is nil")
    }
    
    func testSetArticlesOnTableView() {
        articleTableview.addArticles(mockAPI.getArticlesMock())
        XCTAssertEqual(articleTableview.numberOfRowsInSection(0), 1, "Wrong number or rows in articles tableview")
    }
    
    func testSetArticlesWithNilKeyValues() {
        articleTableview.addArticles(mockAPI.getArticlesWithNilMock())
        XCTAssertEqual(articleTableview.numberOfRowsInSection(0), 2, "Wrong number or rows in articles tableview")
    }
    
}
