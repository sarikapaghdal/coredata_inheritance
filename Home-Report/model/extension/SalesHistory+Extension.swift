//
//  SalesHistory+Extension.swift
//  Home-Report
//
//  Created by Sarika on 26/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import Foundation
import CoreData

extension SalesHistory{
    
    func soldHistoryData(home: Home, context: NSManagedObjectContext) -> [SalesHistory] {
        
        let request : NSFetchRequest<SalesHistory> = SalesHistory.fetchRequest()
        request.predicate = NSPredicate(format: "home = %@", home)
        
        do {
            let soldHistory = try context.fetch(request)
            print(soldHistory)
            return soldHistory
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
