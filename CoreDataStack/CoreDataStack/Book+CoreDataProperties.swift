//
//  Book+CoreDataProperties.swift
//  CoreDataStack
//
//  Created by shujucn on 2018/5/16.
//  Copyright © 2018 shuju. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var bookName: String?
    @NSManaged public var category: String?
    @NSManaged public var publicDate: NSDate?

}
