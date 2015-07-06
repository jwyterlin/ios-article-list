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
        articleTableview.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        articleTableview.protocolDelegate = self
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

