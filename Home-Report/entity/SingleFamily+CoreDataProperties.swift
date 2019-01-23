//
//  SingleFamily+CoreDataProperties.swift
//  Home-Report
//
//  Created by Dhaval s on 22/01/19.
//  Copyright © 2019 Dhaval s. All rights reserved.
//
//

import Foundation
import CoreData


extension SingleFamily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleFamily> {
        return NSFetchRequest<SingleFamily>(entityName: "SingleFamily")
    }

    @NSManaged public var lotSize: Int16

}
