//
//  AllType+CoreDataProperties.swift
//  CoreDataStack
//
//  Created by shujucn on 2018/5/16.
//  Copyright © 2018 shuju. All rights reserved.
//
//

import Foundation
import CoreData


extension AllType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllType> {
        return NSFetchRequest<AllType>(entityName: "AllType")
    }

    @NSManaged public var typeString: String?
    @NSManaged public var typeInt16: Int16
    @NSManaged public var typeInt32: Int32
    @NSManaged public var typeInt64: Int64
    @NSManaged public var typeDecimal: NSDecimalNumber?
    @NSManaged public var typeDouble: Double
    @NSManaged public var typeFloat: Float
    @NSManaged public var typeBoolean: Bool
    @NSManaged public var typeDate: NSDate?
    @NSManaged public var typeBinary: NSData?
    @NSManaged public var typeUUID: UUID?
    @NSManaged public var typeURI: URL?
    @NSManaged public var typeTransformable: NSObject?
    @NSManaged public var typeUndefine: NSObject?

}
