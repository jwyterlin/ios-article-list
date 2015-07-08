//
//  ArticleTableV.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/5/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import UIKit

/**
Custom UITableViewCell for displaying an article
*/
class ArticleTableviewCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleWebsite: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        articleImage.layer.cornerRadius = 45
        articleImage.layer.masksToBounds = true
        articleImage.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    func updateImage(image: UIImage)
    {
        articleImage.image = image
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
    }
    
    func placeHolderImage()
    {
        articleImage.image = UIImage(named: "article-image-placeholder")
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
    }
    
}