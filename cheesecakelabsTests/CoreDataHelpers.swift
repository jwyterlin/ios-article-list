//
//  CoreDataHelpers.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/7/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//

import CoreData
import SwiftyJSON

@testable import cheesecakelabs

func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext? {
    
    let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles([NSBundle.mainBundle()])!
    
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

    let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)

    do {
        try persistentStoreCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    }
        catch
    {
        return nil
    }
    
    return managedObjectContext
}



func getEntityDescription() -> NSEntityDescription? {
    let entity = NSEntityDescription.entityForName("Article", inManagedObjectContext: setUpInMemoryManagedObjectContext()!)
    return entity
}
