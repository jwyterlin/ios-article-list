//
//  ArticleTableview.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/4/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import UIKit

/**
    UITabeview Class that serves as its own delegate and datasource

    Usually the controller is the delegate and datasource, but this can easely make the file bigger.
    There are other patterns where the UITableViewDelegate and UITableViewDatasource are on a separate class
    other than the UITableView and UIViewController.
*/
class ArticleTableview: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var API = Api.sharedInstance
    var protocolDelegate: ArticleTableViewProc?
    var articles: [Article] = [Article]()
    
    override init(frame: CGRect, style: UITableViewStyle)
    {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier: "ArticleTableViewCell")
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArticles(articlesArray: [Article])
    {
        self.articles = articlesArray
    }
    
    // MARK: UITableView delegate functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return articles.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let Cell = self.dequeueReusableCellWithIdentifier("ArticleTableViewCell") as! ArticleTableviewCell
        Cell.articleTitle.text = self.articles[indexPath.row].title
        Cell.articleWebsite.text = self.articles[indexPath.row].website
        Cell.articleDate.text = StringDateConversion.getBRString(self.articles[indexPath.row].date!) as? String

        /**
        If no images available use placeholder
        */
        if let imageUrl = self.articles[indexPath.row].image {
            API.getArticleImage(imageUrl, completion: {
                result in
                Cell.updateImage(result)
            })
        }
        else
        {
            Cell.placeHolderImage()
        }
        
        return Cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        protocolDelegate?.articleSelected(self.articles[indexPath.row])
        let oldCell = tableView.cellForRowAtIndexPath(indexPath)
        oldCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    // TODO: Delete from CoreData    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler:{ action, indexpath in
            self.protocolDelegate?.sharingOptionsSelected()
        });
        moreRowAction.backgroundColor = UIColor.brownColor()
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{ action, indexpath in
            self.articles.removeAtIndex(indexPath.row)
            self.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        });
        
        
        return [deleteRowAction, moreRowAction];
    }

    
}