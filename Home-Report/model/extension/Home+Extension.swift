//
//  Home+Extension.swift
//  Home-Report
//
//  Created by Sarika on 24/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import Foundation
import CoreData

extension Home {
    
    func gethomeByStatus(isForSale: Bool, filter : NSPredicate?, sort : [NSSortDescriptor],  context: NSManagedObjectContext) -> [Home] {
        let request : NSFetchRequest<Home> = Home.fetchRequest()
        var predicates = [NSPredicate]()
        
        let statusPredicate = NSPredicate(format: "isForSale = %@", NSNumber(value: isForSale))
        predicates.append(statusPredicate)
        
        if let addionalPredicate = filter {
            predicates.append(addionalPredicate)
        }
        
        let predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        request.predicate = predicate
        request.sortDescriptors = sort.isEmpty ? nil : sort
        
        do {
            let homes = try context.fetch(request)
            return homes
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
