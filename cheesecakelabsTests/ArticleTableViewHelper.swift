//
//  ArticleTableViewHelper.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/7/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import UIKit

@testable import cheesecakelabs

class ArticleTableviewHelper {

    internal func getArticles() -> [Article]? {
        let article = Article(entity: getEntityDescription()!, insertIntoManagedObjectContext: setUpInMemoryManagedObjectContext())
        article.title = "Restaurant review: Gypsy Apple Bistro in Shelburne Falls one of the region's best"
        article.authors = "Doctor Isaac"
        article.date = NSDate()
        article.website = "www.google.com"
        var articles = [Article]()
        articles.append(article)
        return articles
    }
    
    internal func getNilArticles() -> [Article]? {
        let article = Article(entity: getEntityDescription()!, insertIntoManagedObjectContext: setUpInMemoryManagedObjectContext())
        var articles = [Article]()
        articles.append(article)
        return articles
    }
    
}
