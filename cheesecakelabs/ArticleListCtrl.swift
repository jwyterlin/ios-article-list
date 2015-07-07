//
//  ViewController.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/4/15.
//
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.

import UIKit

class ArticleListCrl: UIViewController, ArticleTableViewProc, ApiProc, UIPopoverPresentationControllerDelegate {
    
    var API: Api = Api.sharedInstance
    var articleTableview: ArticleTableview = ArticleTableview(frame: CGRectZero, style: UITableViewStyle.Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Articles"
        
        API.apiProcDelegate = self
        
        updateTableViewDimentions()

        articleTableview.protocolDelegate = self
        
        getArticles()

    }
    
    func updateTableViewDimentions() {
        
        let rect:CGRect = self.navigationController!.navigationBar.frame;
        
        let y = -rect.origin.y;
        
        articleTableview.frame = CGRectMake(0,
            0,
            self.view.bounds.width,
            self.view.bounds.height)
        self.view.addSubview(articleTableview)
        
        self.articleTableview.contentInset = UIEdgeInsetsMake(y ,0,0,0);

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
        })
    }
    
    func articleSelected(article: Article) {
        let articleContentController = self.storyboard?.instantiateViewControllerWithIdentifier("ArticleContentCtrl") as! ArticleContentCtrl
        self.navigationController?.pushViewController(articleContentController, animated: true)
    }
    
    func didSaveArticles(articles: [Article]) {
        self.articleTableview.addArticles(articles)
        self.articleTableview.reloadData()
    }
    
    func articlesSorted(sortedArticles: [Article]) {
        self.articleTableview.addArticles(sortedArticles)
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
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation:      UIInterfaceOrientation, duration: NSTimeInterval)
    {
        updateTableViewDimentions()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

