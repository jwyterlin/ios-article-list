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
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        
        if let date = formatter.dateFromString(dateString)
        {
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
        Loop through articles array
        */
        for item in articles
        {
            let article = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
            
            /**
            Key, Value loop through item
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
    }
    
    func retriveData(sortBy: String) -> [Article]? {
        
        let managedContext = getContext()
        
        let entity = NSEntityDescription.entityForName("Article", inManagedObjectContext: managedContext)
        let fetchRequest = NSFetchRequest()
        let sortDescriptor = NSSortDescriptor(key: sortBy, ascending: true)
        let sortDescriptors = [sortDescriptor]
        
        
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.returnsObjectsAsFaults = false;
        fetchRequest.entity = entity
        fetchRequest.resultType = NSFetchRequestResultType.ManagedObjectResultType
        fetchRequest.includesPropertyValues = true
        
        do {
            
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [Article]
            return fetchedResults
            
        } catch let fetchError as NSError {
            print("getGalleryForItem error: \(fetchError.localizedDescription)")
            return nil
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
        
        
        
        //print(fetchedResults)
    }
    
}