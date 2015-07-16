//
//  Core.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/5/15.
//  Copyright (c) 2015 Coruja Virtual. All rights reserved.
//

import CoreData
import UIKit

/**
CoreData CRUD helper class
*/
public class Core {
    

    var managedContext: NSManagedObjectContext?
    
    /**
     Inject an In Memory Managed Object Context in order to unit test this class
     without doing CRUD operations with the "real" NSManagedObjectContext and its objects
    */
    func setManagedContext(context: NSManagedObjectContext) {
        managedContext = context
    }
    
    func getContext() -> NSManagedObjectContext
    {
        if managedContext == nil
        {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            managedContext = appDelegate.managedObjectContext
            return managedContext!;
        } else {
            return managedContext!
        }
    }
    

    func createData(articles: NSMutableArray) -> Bool
    {
        let managedContext = getContext()
        
        let entity =  NSEntityDescription.entityForName("Article",
            inManagedObjectContext:managedContext)
        
        /**
        Loop through articles array
        */
        for item: AnyObject in articles
        {
            
            /**
            Check if data exists in CoreData before saving it
            */
            if(dataExists((item["title"] as? String)!, website: (item["website"] as? String)!) == 0) {
                
                let article = Article(entity: entity!, insertIntoManagedObjectContext: managedContext)

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
                            article.setValue(StringDateConversion.getNSDate(value), forKey: k)
                        }
                        else
                        {
                            article.setValue(value, forKey: k)
                        }
                    }
                }
                
            }
            
        }
        
        do {
            
            try managedContext.save()
            
            return true
            
        } catch {
            
            return false
            
        }
        
    }
    
    /**
    Check if data exists in CoreData before saving it
    - parameter title of the website of the article (id would be preferable)
    - returns: int count of duplicates
    */
    func dataExists(title: String, website: String) -> Int
    {
        let managedContext = getContext()
        
        let fetchRequest = NSFetchRequest(entityName:"Article")
        
        let predicate_website = NSPredicate(format: "website = %@", website)
        let predicate_title = NSPredicate(format: "title = %@", website)

        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [predicate_title, predicate_website])

        fetchRequest.predicate = predicate
        
        var error: NSError?
        let count: Int =  managedContext.countForFetchRequest(fetchRequest, error: &error)
        if count == NSNotFound {
            print("Error trying to cound object in CoreData");
            return 0;
        }
        
        return count
    }
    
    /**
    Retrives sorted data based on parameter
    - parameter sort by - title, website, or author. Though is possible to sort by any parameter contained in the Article model
    - returns: Array of Article model
    */
    func retriveData(sortBy: String) -> [Article]?
    {
        
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
            
            var articles = [Article]()
            
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [Article]
            
            articles = fetchedResults!
            
            return articles
            
        } catch let fetchError as NSError {
            print("getGalleryForItem error: \(fetchError.localizedDescription)")
            return nil
        }
    }
    
    /**
    - TODO: Select Article by title and website and update read field
    */
    func updateData(title: String, website: String) -> Bool
    {
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest(entityName:"Article")
        let predicate = NSPredicate(format: "website = %@", "Into Mobile")
        
        fetchRequest.returnsObjectsAsFaults = false;
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchedResults: NSArray = try managedContext.executeFetchRequest(fetchRequest)
        
            let article: NSManagedObject = fetchedResults.objectAtIndex(0) as! NSManagedObject
            
            article.setValue(true, forKey: "read")
            
            try managedContext.save()
            
            return true

        } catch {
            
            print("Could not save to core data")
            
            return false
        }
        
    }
    
    func deleteData(article: Article)
    {
        let managedContext = getContext()
        managedContext.deleteObject(article as NSManagedObject)
    }
    
}