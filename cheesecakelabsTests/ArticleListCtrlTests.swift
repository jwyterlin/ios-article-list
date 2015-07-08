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
    
    func testArticleListCtrlConformsToApiProtocol() {
        XCTAssertTrue(articleListCrl is ApiProc, "articleListCrl does not conform to ApiProtocol")
    }
    
    func testArticleListCtrlConformsToArticleTableViewProtocol() {
        XCTAssertTrue(articleListCrl is ArticleTabManagerProc, "articleListCrl does not conform to ArticleTableViewProtocol")
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
    
    func testTableViewCellNotNil() {
        mockAPI.setFullArticles()
        articleListCrl!.API = mockAPI
        articleListCrl!.viewDidLoad()
        articleListCrl!.loadView()
        let cell = articleListCrl!.articleTableview.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ArticleTableviewCell
        XCTAssertNotNil(cell)
    }
    
    func testTableViewCellNil() {
        mockAPI.setNilArticles()
        articleListCrl!.API = mockAPI
        articleListCrl!.viewDidLoad()
        articleListCrl!.loadView()
        let cell = articleListCrl!.articleTableview.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? ArticleTableviewCell
        XCTAssertNil(cell)
    }
    
    func testShowTitleWebsiteAndDateInTableViewCell() {
        mockAPI.setFullArticles()
        articleListCrl!.API = mockAPI
        articleListCrl!.viewDidLoad()
        articleListCrl!.loadView()
        articleListCrl!.articleTableview.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .None)
        let cell = articleListCrl!.articleTableview.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ArticleTableviewCell
        XCTAssertEqual(cell.articleWebsite.text!, String("John"))
        XCTAssertEqual(cell.articleTitle.text!, String("Restaurant review: Gypsy Apple Bistro in Shelburne Falls one of the region's best"))
        XCTAssertEqual(cell.articleDate.text!, String("27/05/2014"))
    }

    func testPerformanceExample() {
        self.measureBlock() {
        }
    }

}
