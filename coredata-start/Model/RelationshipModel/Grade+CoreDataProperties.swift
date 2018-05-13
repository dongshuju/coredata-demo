//
//  Grade+CoreDataProperties.swift
//  coredata-start
//
//  Created by shujucn on 2018/5/13.
//  Copyright © 2018 shuju. All rights reserved.
//
//

import Foundation
import CoreData


extension Grade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grade> {
        return NSFetchRequest<Grade>(entityName: "Grade")
    }

    @NSManaged public var name: String?
    @NSManaged public var teachers: Set<Teacher>

}
