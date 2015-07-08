//
//  HomeCtrl.swift
//  ckl
//
//  Created by Israel Tavares on 7/6/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import XCTest
@testable import cheesecakelabs

class HomeCtrlTests: XCTestCase {

    var articleListCrl: ArticleListCrl?
    let mockAPI = MockApi.sharedInstance
    
    override func setUp() {
        articleListCrl = ArticleListCrl()
        super.setUp()
    }
    
    override func tearDown() {
        articleListCrl = nil
        super.tearDown()
    }

    func testHomeCtrlLoaded() {
        XCTAssertNotNil(articleListCrl, "HomeCtrl is nil")
    }
    
    func testArticleTableViewNotNil() {
        articleListCrl!.viewDidLoad()
        XCTAssertNotNil(articleListCrl!.articleTableview, "articleTableview is nil")
    }
    
    func testArticleTableViewDataSource() {
        articleListCrl!.viewDidLoad()
        XCTAssertNotNil(articleListCrl!.articleTableview.dataSource,"articleTableView dataSource is nil")
    }
    
    func testArticleTableviewDelegateSet() {
        articleListCrl!.viewDidLoad()
        XCTAssertNotNil(articleListCrl!.articleTableview.delegate,"articleTableView dataSource is nil")
    }
    
    func testAddArticlesToTableView() {
        mockAPI.setFullArticles()
        articleListCrl!.API = mockAPI
        articleListCrl!.viewDidLoad()
        XCTAssertEqual(articleListCrl!.articleTableview.numberOfRowsInSection(0), 2, "Wrong number or rows in articles tableview")
    }
    
    func testAddArticlesWithNilKeyValue() {
        mockAPI.setNilArticles()
        articleListCrl!.API = mockAPI
        articleListCrl!.viewDidLoad()
        XCTAssertEqual(articleListCrl!.articleTableview.numberOfRowsInSection(0), 0, "Wrong number or rows in articles tableview")
    }
    
    func testArticleListCtrlConformsToArticleTableViewProtocol() {
        XCTAssertTrue(articleListCrl is ArticleTabManagerProc, "articleListCrl does not conform to ArticleTableViewProtocol")
    }
    

    func testArticleListCtrlConformsToApiProtocol() {
        XCTAssertTrue(articleListCrl is ApiProc, "articleListCrl does not conform to ApiProtocol")
    }

    func testPerformanceExample() {
        self.measureBlock() {
        }
    }

}
