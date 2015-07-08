//
//  MockApi.swift
//  ckl
//
//  Created by Israel Tavares on 7/5/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import Foundation
import SwiftyJSON

@testable import cheesecakelabs

/**
Inherits from the Api class and overrides its functions
*/
class MockApi: Api {
    
    override class var sharedInstance: MockApi {
        struct Static {
            static let instance: MockApi = MockApi()
        }
        return Static.instance
    }
    
    override func getApiProtocol()-> ApiProc? {
        return self.apiProcDelegate
    }
        
    var jsonObject: [AnyObject] = []
    
    /**
    :returns: mocked articles json object
    */
    func setFullArticles() {
        self.jsonObject = [
            [
                "website": "John",
                "title": "Restaurant review: Gypsy Apple Bistro in Shelburne Falls one of the region's best",
                "image": "http://lorempixel.com/400/400/technics/2/",
                "content": "Interdum et malesuada fames ac ante ipsum primis in faucibus. Nam ut eleifend ligula. Aliquam mattis dui nec est semper, vel dignissim enim pulvinar. In pharetra vel neque sodales finibus. Cras euismod lorem mi, ac consectetur ipsum auctor quis. Vivamus condimentum placerat augue rhoncus volutpat. Phasellus porta dolor eu tellus efficitur vehicula ornare vitae diam. Sed est est, luctus sit amet lobortis vitae, sagittis et sapien. Sed et tellus libero.",
                "authors": "Fran Bellamy",
                "date": "05/27/2014"
            ],
            [
                "website": "Jack",
                "title": "Restaurant review: Gypsy Apple Bistro in Shelburne Falls one of the region's best"
            ]
        ]
    }
    /**
    :returns mocked articles json with nil object
    */
    func setNilArticles() {
        jsonObject = [
            [],
            []
        ]
    }
    
    func setArticlesWithNoImage() {
        jsonObject = [
            [
                "website": "John",
                "image": "http://lorempixel.com/400/400/technics/2/",
                "title": "Restaurant review: Gypsy Apple Bistro in Shelburne Falls one of the region's best",
                "authors": "Fran Bellamy",
                "date": "05/27/2014"
            ],
            []
        ]
    }
        
    /**
    :returns mocked articles json object
    */
    override func getArticles() {
        let articles = NSMutableArray()
        for (_, value) in JSON(jsonObject)
        {
            if let object = value.dictionaryObject {
                articles.addObject(object)
            }
            
        }
        self.saveArticles(articles)
    }
    
    override func getArticleImage(url: String, completion: (result: UIImage) -> Void) {
        let image = UIImage()
        completion(result: image)
    }
    
    /**
    Perform the same loops perfomed in Core.createData in order to convert the mock objects to Article model
    */
    override func saveArticles(articles: NSMutableArray) {
        
        var articlesArray = [Article]()
        /**
        Loop through articles array
        */
        for item in articles
        {
            let article = Article(entity: getEntityDescription()!, insertIntoManagedObjectContext: setUpInMemoryManagedObjectContext())
            
            /**
            Key, Value loop through item
            */
            for(k, v) in item as! [String: AnyObject]
            {
                if let value = v as? String
                {
                    /**
                    Convert date to NSDate
                    */
                    if k == "date"
                    {
                        article.setValue(StringDateConversion.getNSDate(value), forKey: k)
                    }
                    else
                    {
                        article.setValue(value, forKey: k)
                    }
                }
            }
            
            articlesArray.append(article)
            
        }
        
        getApiProtocol()?.didSaveArticles(articlesArray)
    }
    
    override func sortArticlesBy(sortBy: String) {
        
    }
    
}