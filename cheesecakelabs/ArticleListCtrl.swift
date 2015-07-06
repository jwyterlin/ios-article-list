//
//  ViewController.swift
//  ckl
//
//  Created by Israel Tavares on 7/4/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import UIKit

class ArticleListCrl: UIViewController, ArticleTableViewProtocol {
    
    var API: Api = Api.sharedInstance
    var articleTableview: ArticleTableview = ArticleTableview(frame: CGRectZero, style: UITableViewStyle.Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Articles"
        
        let NAVIGATION_BAR_HEIGHT = self.navigationController?.navigationBar.frame.height
        let STATUS_BAR_HEIGHT = UIApplication.sharedApplication().statusBarFrame.size.height
                
        articleTableview.frame = CGRectMake(0,
            NAVIGATION_BAR_HEIGHT! + STATUS_BAR_HEIGHT,
            self.view.bounds.width,
            self.view.bounds.height-(NAVIGATION_BAR_HEIGHT! + STATUS_BAR_HEIGHT))
        articleTableview.protocolDelegate = self
        articleTableview.separatorColor = UIColor.clearColor()
        self.view.addSubview(articleTableview)
        getArticles()

    }
    
    func getArticles() {
        API.getArticles({
            result in
            let articles = NSMutableArray()
            for (_, value) in result
            {
                if let object = value.dictionaryObject {
                    articles.addObject(object)
                }
                
            }
            self.API.saveArticles(articles)
            self.articleTableview.addArticles(articles)
            self.articleTableview.reloadData()
        })
    }
    
    func articleSelected(article: NSDictionary) {
        let articleContentController = self.storyboard?.instantiateViewControllerWithIdentifier("ArticleContentCtrl") as! ArticleContentCtrl
        self.navigationController?.pushViewController(articleContentController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

