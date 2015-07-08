//
//  ArticleListCrl.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/4/15.
//
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.

import UIKit

class ArticleListCrl: UIViewController, ArticleTableViewProc, ApiProc, UIPopoverPresentationControllerDelegate {
    
    var API: Api = Api.sharedInstance
    var articleTableview: ArticleTableview = ArticleTableview(frame: CGRectZero, style: UITableViewStyle.Plain)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Articles"
        self.navigationController?.navigationBar.translucent = false;

        API.apiProcDelegate = self
        articleTableview.protocolDelegate = self
        
        updateTableViewDimentions()
        getArticles()
        
    }
    
    func updateTableViewDimentions()
    {
        articleTableview.frame = self.view.bounds;
        articleTableview.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(articleTableview)
    }
    
    func getArticles()
    {
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
    
    // MARK: ArticleTableView Protocol functions
    
    func articleSelected(article: Article)
    {
        let articleContentController = self.storyboard?.instantiateViewControllerWithIdentifier("ArticleContentCtrl") as! ArticleContentCtrl
        self.navigationController?.pushViewController(articleContentController, animated: true)
    }
    
    func sharingOptionsSelected() {
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: Api Protocol functions

    func didSaveArticles(articles: [Article])
    {
        self.articleTableview.addArticles(articles)
        self.articleTableview.reloadData()
    }
    
    func articlesSorted(sortedArticles: [Article])
    {
        self.articleTableview.addArticles(sortedArticles)
        self.articleTableview.reloadData()
    }
    
    // MARK:
    /**
    Force popover presentation on iPhone
    */
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
    }
    
    /**
    Force popover presentation on iPhone
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
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

