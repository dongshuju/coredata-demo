//
//  Library+CoreDataProperties.swift
//  coredata-start
//
//  Created by shujucn on 2018/5/9.
//  Copyright © 2018 shuju. All rights reserved.
//
//

import Foundation
import CoreData


extension Library {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Library> {
        return NSFetchRequest<Library>(entityName: "Library")
    }

    @NSManaged public var name: String?
    @NSManaged public var readers: Set<Reader>?
    @NSManaged public var books: Set<Book>

}
