//
//  Home+CoreDataClass.swift
//  Home-Report
//
//  Created by Sarika on 22/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Home)
public class Home: NSManagedObject {
    
    private let isForSalePredicate = NSPredicate(format: "isForSale = false")
    private let request : NSFetchRequest<Home> = Home.fetchRequest()
    
    //sum
    func totalSoldHomeValues(moc: NSManagedObjectContext) -> Double {
        request.predicate = isForSalePredicate
        request.resultType = .dictionaryResultType
        
        //when we get sum "totalSales" will be key for that dictionary
        let sumExpression = NSExpressionDescription()
        sumExpression.name = "totalSales"
        sumExpression.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpression.expressionResultType = .doubleAttributeType
        request.propertiesToFetch = [sumExpression]
        
        if let results = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [NSDictionary],
                let totalSales = results?.first?["totalSales"] as? Double {
             return totalSales
        }
        
        return 0
    }
    
    func totalSoldCondo(moc : NSManagedObjectContext) -> Int {
        
        let typePredicate = NSPredicate(format: "homeType = '\(HomeType.Condo.rawValue)'")
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [isForSalePredicate, typePredicate])
        request.resultType = .countResultType
        request.predicate = predicate
        
        if let results = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [Int],
            let counts = results?.first {
            return counts
        }
        
        return 0
    }
    
    func totalSoldFamily(moc : NSManagedObjectContext) -> Int {
        let typePredicate = NSPredicate(format: "homeType = '\(HomeType.SingleFamily.rawValue)'")
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [isForSalePredicate, typePredicate])
        request.predicate = predicate
        
        if let counts = try? moc.count(for: request), counts != NSNotFound {
            return counts
        }
        return 0
    }
    
    func soldPrice(priceType : String, moc : NSManagedObjectContext) -> Double {
        request.predicate = isForSalePredicate
        request.resultType = .dictionaryResultType
        
        //when we get sum "totalSales" will be key for that dictionary
        let sumExpression = NSExpressionDescription()
        sumExpression.name = priceType
        sumExpression.expression = NSExpression(forFunction: "\(priceType):", arguments: [NSExpression(forKeyPath: "price")]) //min : max
        sumExpression.expressionResultType = .doubleAttributeType
        request.propertiesToFetch = [sumExpression]
        
        if let results = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [NSDictionary],
            let homePrice = results?.first?[priceType] as? Double {
            return homePrice
        }
        
        return 0
    }
    
    func averagePrice(homeType : HomeType, moc : NSManagedObjectContext) -> Double {
        let typePredicate = NSPredicate(format: "homeType = %@", homeType.rawValue)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [isForSalePredicate, typePredicate])
        request.predicate = predicate
        request.resultType = .dictionaryResultType
        
        let sumExpression = NSExpressionDescription()
        sumExpression.name = homeType.rawValue
        sumExpression.expression = NSExpression(forFunction: "average:", arguments: [NSExpression(forKeyPath: "price")]) //average
        sumExpression.expressionResultType = .doubleAttributeType
        request.propertiesToFetch = [sumExpression]
        
        if let results = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [NSDictionary],
            let homePrice = results?.first?[homeType.rawValue] as? Double {
            return homePrice
        }
        
        
        return 0
    }
}
