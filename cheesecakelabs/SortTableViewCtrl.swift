//
//  SortTableView.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/6/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import UIKit

class SortTableViewCtrl: UITableViewController {
    
    @IBOutlet var sortTableView: UITableView!
    
    var options: NSArray = NSArray(array: ["Title", "Date", "Authors", "Website"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortTableView?.delegate = self
        sortTableView?.dataSource = self
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SortTableViewCell", forIndexPath: indexPath) as UITableViewCell
        
        if let text = options[indexPath.row] as? String {
            cell.textLabel?.text = text
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let option = (options[indexPath.row] as! NSString).lowercaseString as String
        Api.sharedInstance.sortArticlesBy(option)
    }
    
}
