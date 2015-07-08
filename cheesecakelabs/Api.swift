//
//  Api.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/4/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import Alamofire
import SwiftyJSON

public class Api {
    
    private final let CORE = Core()
    private final let imageCache = NSCache()
    private final let ARTICLES_URL = "http://www.ckl.io/challenge/"
    private final let DEFAULT_SORTING = "title"

    var apiProcDelegate: ApiProc?
    
    /**
    Make this class singleton
    */
    public class var sharedInstance: Api
    {
        struct Static
        {
            static let instance: Api = Api()
        }
        return Static.instance
    }
    
    
    func getApiProtocol() -> ApiProc?
    {
        return self.apiProcDelegate
    }
    
    /**
    Gets articles from server and save them as persisten data
    */
    public func getArticles()
    {
        Alamofire.request(.GET, URLString: ARTICLES_URL)
            .responseJSON { (_, _, data, _) in
                
                let articles = NSMutableArray()
                for (_, value) in JSON(data!)
                {
                    if let object = value.dictionaryObject {
                        articles.addObject(object)
                    }
                    
                }
                self.saveArticles(articles)
        }
    }
    
    /**
    Save articles in CoreData and send it  [Article] array to ArticleListCtrl
    */
    func saveArticles(articles: NSMutableArray)
    {
        if(CORE.createData(articles)) {
            if let articles = CORE.retriveData(DEFAULT_SORTING) {
                apiProcDelegate?.articlesSorted(articles)
            }
        }
    }
    
    /**
    Gets image from server and caches it the first time.
    - parameter url: path to image, callback function
    - returns: returns image or cachedImage
    */
    func getArticleImage(url: String, completion: (result: UIImage) -> Void)
    {
        if let cachedImage = imageCache.objectForKey(url) as? UIImage
        {
            completion(result: cachedImage)
        }
        else
        {
            Alamofire.request(.GET, URLString: url).response() {
                (_, _, data, _) in
                if let image = UIImage(data: data! as! NSData) {
                    completion(result: image)
                    self.imageCache.setObject(image, forKey: url)
                }
            }
        }
    }
    
    /**
    Sort Article by title, date, website and authors
    */
    func sortArticlesBy(sortBy: String)
    {
        if let articles = CORE.retriveData(sortBy)
        {
            apiProcDelegate?.articlesSorted(articles)
        }
    }
    
    func deleteArticle(article: Article) {
        CORE.deleteData(article)
    }
    
}