//
//  ViewController.swift
//  ckl
//
//  Created by Israel Tavares on 7/4/15.
//
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.

import UIKit

class ArticleListCrl: UIViewController, ArticleTableViewProc, SortProc, UIPopoverPresentationControllerDelegate {
    
    var API: Api = Api.sharedInstance
    var articleTableview: ArticleTableview = ArticleTableview(frame: CGRectZero, style: UITableViewStyle.Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Articles"
        
        API.sortProcDelegate = self
        
        articleTableview.frame = CGRectMake(0,
            60,
            self.view.bounds.width,
            self.view.bounds.height - 60)
        self.view.addSubview(articleTableview)
        articleTableview.protocolDelegate = self
        
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
    
    func articlesSorted(sortedArticles: [Article]) {
        let articles = NSMutableArray()
        for item: Article in sortedArticles {
            articles.addObject(item.dictionaryWithValuesForKeys(["website", "title", "authors", "image", "date", "content"]))
        }
        self.articleTableview.addArticles(articles)
        self.articleTableview.reloadData()
    }
    
    /**
    Force popover presentation on iPhone
    */
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    /**
    Force popover presentation on iPhone
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SortPopover" {
            let popoverViewController = segue.destinationViewController as UIViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

