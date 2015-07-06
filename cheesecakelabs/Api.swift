//
//  Api.swift
//  ckl
//
//  Created by Israel Tavares on 7/4/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

public class Api {
    
    private final let imageCache = NSCache()
    private final let ARTICLES_URL = "http://www.ckl.io/challenge/"
    private final let CORE = Core()
    
    var sortProcDelegate: SortProc?
    
    public class var sharedInstance: Api {
        struct Static {
            static let instance: Api = Api()
        }
        return Static.instance
    }
    
    public func getArticles(completion: (result: JSON) -> Void) {
        Alamofire.request(.GET, URLString: ARTICLES_URL)
            .responseJSON { (_, _, data, _) in
                let articles = JSON(data!)
                completion(result: articles)
        }
    }
    /**
    Gets image from server and caches it the first time.
    
    - parameter url: path to image, callback function
    - returns: returns image or cachedImage
    
    */
    func getArticleImage(url: String, completion: (result: UIImage) -> Void) {
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
    
    func saveArticles(articles: NSMutableArray) {
        CORE.createData(articles)
    }
    
    func sortArticlesBy(sortBy: String){
        if let articles = CORE.retriveData(sortBy) {
            sortProcDelegate?.articlesSorted(articles)
        }
    }
    
}