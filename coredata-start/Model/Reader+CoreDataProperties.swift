//
//  Reader+CoreDataProperties.swift
//  coredata-start
//
//  Created by shujucn on 2018/5/9.
//  Copyright © 2018 shuju. All rights reserved.
//
//

import Foundation
import CoreData


extension Reader {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reader> {
        return NSFetchRequest<Reader>(entityName: "Reader")
    }

    @NSManaged public var age: Int32
    @NSManaged public var name: String?
    @NSManaged public var personNumber: Int16
    @NSManaged public var books: Book?

}
