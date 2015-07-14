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

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        articleContenttCrl = storyboard.instantiateViewControllerWithIdentifier("ArticleContentCtrl") as? ArticleContentCtrl
    }
    
    override func tearDown() {
        articleContenttCrl = nil
        super.tearDown()
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(articleContenttCrl)
    }
    
    func testArticleNotNil() {
        articleContenttCrl?.article = mockAPI.getArticleObject()
        XCTAssertNotNil(articleContenttCrl?.article)
    }
    
    // More than one assert...but it's ok in this case
    func testViewDidLoadArticle() {
        articleContenttCrl!.API =  mockAPI
        articleContenttCrl!.article = mockAPI.getArticleObject()
        articleContenttCrl!.loadView()
        articleContenttCrl!.viewDidLoad()
        XCTAssertEqual((articleContenttCrl?.articleTitle.text)!, "John")
        XCTAssertEqual((articleContenttCrl?.articleAuthor.text)!, "Fran Bellamy")
        XCTAssertEqual((articleContenttCrl?.articleContent.text)!, NSString(string: "my content"))
        XCTAssertEqual((articleContenttCrl?.articleDate.text)!, NSString(string: "27/05/2014"))
        XCTAssertNotNil(articleContenttCrl?.articleImage.image)
    }
    
    // More than one assert...but it's ok in this case
    func testViewDidLoadArticleWithNilValues() {
        articleContenttCrl!.article = mockAPI.getArticleWithNilValues()
        articleContenttCrl!.loadView()
        articleContenttCrl!.viewDidLoad()
        XCTAssertEqual(String(articleContenttCrl?.articleTitle.text), "nil")
        XCTAssertEqual(String(articleContenttCrl?.articleAuthor.text), "nil")
        XCTAssertEqual((articleContenttCrl?.articleContent.text)!, NSString(string: ""))
        XCTAssertEqual((articleContenttCrl?.articleDate.text)!, NSString(string: "Date"))
        XCTAssertNotNil(articleContenttCrl?.articleImage.image)
    }

}