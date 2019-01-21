//
//  Condo+CoreDataProperties.swift
//  Home-Report
//
//  Created by Sarika on 21/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//
//

import Foundation
import CoreData


extension Condo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Condo> {
        return NSFetchRequest<Condo>(entityName: "Condo")
    }

    @NSManaged public var unitsPerBuilding: Int16

}
