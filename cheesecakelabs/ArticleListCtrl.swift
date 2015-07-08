//
//  ArticleListCrl.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/4/15.
//
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.

import UIKit

class ArticleListCrl: UIViewController, ArticleTabManagerProc, ApiProc, UIPopoverPresentationControllerDelegate {
    
    var API: Api = Api.sharedInstance
    var articleTableview = UITableView(frame: CGRectZero, style: .Plain)
    var tableviewManager = ArticleTableManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Articles"
        self.navigationController?.navigationBar.translucent = false;

        API.apiProcDelegate = self
        tableviewManager.protocolDelegate = self
        
        configureArticleTableView()
        API.getArticles()
        
    }
    
    func configureArticleTableView()
    {
        articleTableview.frame = self.view.bounds;
        articleTableview.delegate = tableviewManager
        articleTableview.dataSource = tableviewManager
        articleTableview.showsVerticalScrollIndicator = false
        articleTableview.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        articleTableview.registerNib(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        self.view.addSubview(articleTableview)
    }
    
    // MARK: ArticleTableView Protocol implementation
    
    func articleSelected(article: Article)
    {
        let articleContentController = self.storyboard?.instantiateViewControllerWithIdentifier("ArticleContentCtrl") as! ArticleContentCtrl
        articleContentController.article = article
        self.navigationController?.pushViewController(articleContentController, animated: true)
    }
    
    func deleteArticle(article: Article) {
        API.deleteArticle(article)
    }
    
    // FIXME: Fix debbuger complaints
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
        
        activityViewController.popoverPresentationController!.sourceView = self.view;
        self.presentViewController(activityViewController, animated: true, completion: nil)

    }
    
    // MARK: Api Protocol implementation

    func didSaveArticles(articles: [Article])
    {
        self.tableviewManager.addArticles(articles)
        self.articleTableview.reloadData()
    }
    
    func articlesSorted(sortedArticles: [Article])
    {
        self.tableviewManager.addArticles(sortedArticles)
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
        articleTableview.frame = self.view.bounds;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

