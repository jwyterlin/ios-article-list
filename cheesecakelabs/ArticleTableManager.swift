//
//  ArticleTableview.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/4/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import UIKit

/**
Usually the controller is the delegate and datasource, but this can easely make the file bigger.
There are other patterns where the UITableViewDelegate and UITableViewDatasource are on a separate class
other than the UITableView and UIViewController.
*/
class ArticleTableManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var API = Api.sharedInstance
    var protocolDelegate: ArticleTabManagerProc?
    var articles: [Article] = [Article]()
    
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
        
        let Cell = tableView.dequeueReusableCellWithIdentifier("ArticleTableViewCell") as! ArticleTableviewCell
        
        Cell.articleTitle.text = self.articles[indexPath.row].title
        Cell.articleWebsite.text = self.articles[indexPath.row].website
        Cell.articleAuthor.text = self.articles[indexPath.row].authors
        Cell.articleImage.image = nil
        Cell.activityIndicator.startAnimating()

        if let date = self.articles[indexPath.row].date {
            Cell.articleDate.text = StringDateConversion.getBRString(date) as? String
        }
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
        protocolDelegate?.articleSelected(self.articles[indexPath.row] as Article)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler:{ action, indexpath in
            self.protocolDelegate?.sharingOptionsSelected()
        });
        moreRowAction.backgroundColor = UIColor.brownColor()
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{ action, indexpath in
            self.articles.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.protocolDelegate?.deleteArticle(self.articles.removeAtIndex(indexPath.row))

        });
        
        return [deleteRowAction, moreRowAction];
    }
    
    
}