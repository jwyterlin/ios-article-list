//
//  ArticleContentCtrl.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/5/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import UIKit

class ArticleContentCtrl: UIViewController {
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleImageBackground: UIView!
    
    let API = Api.sharedInstance
    var article: Article?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        articleImage.layer.cornerRadius = 190
        articleImage.layer.masksToBounds = true
        articleImage.clipsToBounds = true
        articleTitle.text = article!.valueForKey("title") as? String
        articleAuthor.text = article?.authors
        articleDate.text = StringDateConversion.getBRString((article?.date)!) as! String
        articleContent.text = article?.content
        articleContent.font = UIFont(name: "Helvetica Neue", size: 18)
        if let image = article!.image
        {
            API.getArticleImage(image, completion: {
                result in
                self.articleImage.image = result
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidden = true
            })
        }
            else
        {
            articleImage.image = UIImage(named: "content-image-placeholder")
            activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
        }
        
        setArticleImageBackgroundPattern()
        
    }
    
    /**
    Set the image pattern for the background holding the article image
    */
    func setArticleImageBackgroundPattern() {
        
        let patterns = NSArray(
            array:
            [
                "article-background-pattern",
                "article-background-pattern-2",
                "article-background-pattern-3"
            ]
        )
        
        articleImageBackground.backgroundColor =
            UIColor(
                patternImage: UIImage(
                    named: patterns[random() % patterns.count] as! String)!)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}