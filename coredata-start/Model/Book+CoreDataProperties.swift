//
//  Book+CoreDataProperties.swift
//  coredata-start
//
//  Created by shujucn on 2018/5/9.
//  Copyright © 2018 shuju. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var name: String?
    @NSManaged public var publicDate: NSDate?
    @NSManaged public var category: String?
    @NSManaged public var newName: String?
    @NSManaged public var reader: Reader?
    @NSManaged public var library: Library?

}
