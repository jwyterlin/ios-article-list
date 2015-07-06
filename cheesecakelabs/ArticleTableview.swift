//
//  ArticleTableview.swift
//  ckl
//
//  Created by Israel Tavares on 7/4/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ArticleTableview: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var API = Api.sharedInstance
    var protocolDelegate: ArticleTableViewProc?
    var articles: NSArray = NSArray()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.showsVerticalScrollIndicator = false
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier: "ArticleTableViewCell")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArticles(suggestionArray: NSArray) {
        self.articles = suggestionArray
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let Cell = self.dequeueReusableCellWithIdentifier("ArticleTableViewCell") as! ArticleTableviewCell
        Cell.articleTitle.text = self.articles[indexPath.row]["title"] as? String
        Cell.articleWebsite.text = self.articles[indexPath.row]["website"] as? String
        Cell.articleDate.text = self.articles[indexPath.row]["date"] as? String
        
        if let imageUrl = self.articles[indexPath.row]["image"] as? String {
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        protocolDelegate?.articleSelected(self.articles[indexPath.row] as! NSDictionary)
    }
    
}