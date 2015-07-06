//
//  Article+CoreDataProperties.swift
//  cheesecakelabs
//
//  Created by Israel Tavares on 7/7/15.
//  Copyright © 2015 Coruja Virtual. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Article {

    @NSManaged var authors: String?
    @NSManaged var content: String?
    @NSManaged var date: NSDate?
    @NSManaged var image: String?
    @NSManaged var read: NSNumber?
    @NSManaged var title: String?
    @NSManaged var website: String?

}
