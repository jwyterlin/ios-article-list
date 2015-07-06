//
//  File.swift
//  ckl
//
//  Created by Israel Tavares on 7/5/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON

/**
CoreData CRUD helper class
*/
public class Core {
    

    public func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        return managedContext;
    }
    
    func dateFormatter(dateString: String) -> (possible: Bool, date: NSDate) {
        
        print(dateString)
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "pt")
        formatter.dateFormat = "dd-mm-yyyy"
        //let date = formatter.dateFromString("Thu, 04 Sep 2014 10:50:12 +0000")
        
                
        if let date = formatter.dateFromString(dateString)
        {
            print(date)
            return (true, date)
        }
            else
        {
            return (false, NSDate())
        }
    }
    
    /**
    - TODO: Use a library to map objects - JSON to swift objects
    check https://github.com/tristanhimmelman/AlamofireObjectMapper
    */
    func createData(articles: NSMutableArray) {
        let managedContext = getContext()
        
        let entity =  NSEntityDescription.entityForName("Article",
            inManagedObjectContext:managedContext)

        /**
        Loop though articles array
        */
        for item in articles
        {
            let article = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
            
            /**
            Key, Value loop in item
            */
            for(k, v) in item as! [String: AnyObject]
            {
                if let value = v as? String
                {
                    /**
                    Convert date to NSDate
                    */
                    if k == "date"
                    {
                        if(dateFormatter(value).possible)
                        {
                            article.setValue(dateFormatter(value).date, forKey: k)
                        }
                    }
                        else
                    {
                        article.setValue(value, forKey: k)
                    }
                }
            }

        }
        retriveData()
    }
    
    func retriveData() {
        let managedContext = getContext()
        
        let fetchRequest = NSFetchRequest(entityName:"Article")
        
        do {
            
            let fetchedResults: NSArray = try managedContext.executeFetchRequest(fetchRequest)
            
            print(fetchedResults)
            
        } catch {
            print(error)
        }
        
    }
    
    func updateData() {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest(entityName:"Article")
        let predicate = NSPredicate(format: "website = %@", "Into Mobile")
        
        fetchRequest.returnsObjectsAsFaults = false;
        fetchRequest.predicate = predicate
        
        
        do {
            
            let fetchedResults: NSArray = try managedContext.executeFetchRequest(fetchRequest)
        
            let article: NSManagedObject = fetchedResults.objectAtIndex(0) as! NSManagedObject
            
            article.setValue(true, forKey: "read")
            
        } catch {
            print(error)
        }
        
        
        
        retriveData()
        //print(fetchedResults)
    }
    
}