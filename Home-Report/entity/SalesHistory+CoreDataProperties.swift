//
//  SalesHistory+CoreDataProperties.swift
//  Home-Report
//
//  Created by Sarika on 22/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//
//

import Foundation
import CoreData


extension SalesHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SalesHistory> {
        return NSFetchRequest<SalesHistory>(entityName: "SalesHistory")
    }

    @NSManaged public var soldDate: NSDate?
    @NSManaged public var soldPrice: Double
    @NSManaged public var home: Home?

}
