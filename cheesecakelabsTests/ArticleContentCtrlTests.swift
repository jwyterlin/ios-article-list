//
//  ArticleContentCtrlTests.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/8/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import Foundation

import XCTest
@testable import cheesecakelabs

class ArticleContentCtrlTests: XCTestCase {

    var articleContenttCrl: ArticleContentCtrl?
    let mockAPI = MockApi.sharedInstance
    
    override func setUp() {
        super.setUp()
        articleContenttCrl = ArticleContentCtrl()
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(articleContenttCrl)
    }
    
    func testArticleNotNil() {
        articleContenttCrl?.article = mockAPI.getArticleObject()
        XCTAssertNotNil(articleContenttCrl?.article)
    }
    
    func testViewDidLoad() {
        articleContenttCrl!.article = mockAPI.getArticleObject()
        articleContenttCrl!.loadView()
        articleContenttCrl!.viewDidLoad()
        XCTAssertNotNil(articleContenttCrl?.article)
    }
    
    //TODO FIX IBOutlets being nil on viewDidLoad()
    func testViewDidLoad2() {
//        articleContenttCrl!.article = mockAPI.getArticleObject()
//        articleContenttCrl?.view
//        articleContenttCrl!.loadView()
//        articleContenttCrl!.viewDidLoad()
//        XCTAssertNotNil(articleContenttCrl?.articleTitle)
    }
    
    override func tearDown() {
        articleContenttCrl = nil
        super.tearDown()
    }

}