//
//  AppDelegate.swift
//  Home-Report
//
//  Created by Sarika on 21/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreData = CoreDataStack()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkDataStore()
        
        let managedObjectContext = coreData.persistentContainer.viewContext
        
        let tabBarController = self.window?.rootViewController as! UITabBarController
        
        // First Tab - Home List
        let homeListNavigationController = tabBarController.viewControllers?[0] as! UINavigationController
        let homeListViewController = homeListNavigationController.topViewController as! HomeListViewController
        homeListViewController.managedObjectContext = managedObjectContext
        
        // Second Tab - Summary View
        let summaryNavigationController = tabBarController.viewControllers?[1] as! UINavigationController
        let summaryViewController = summaryNavigationController.topViewController as! SummaryTableViewController
        summaryViewController.managedObjectContext = managedObjectContext
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreData.saveContext()
    }
    
    func checkDataStore() {
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        
        let context = coreData.persistentContainer.viewContext
        do {
            let homeCount = try context.count(for: request)
            
            if homeCount == 0 {
                uploadSampleData()
            }
        }
        catch {
            fatalError("Error in counting home record")
        }
    }
    
    func uploadSampleData()
    {
        let context = coreData.persistentContainer.viewContext
        if let url = Bundle.main.url(forResource: "homes", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary,
                    let jsonArray =  jsonResult.value(forKey: "home") as? NSArray   {
                    
                    
                    for json in jsonArray {
                        if let homeData = json as? [String : AnyObject]{
                            
                        guard
                            
                            let bath = homeData["bath"],
                            let bed = homeData["bed"],
                            let city = homeData["city"],
                            let price = homeData["price"],
                            let sqft = homeData["sqft"],
                            let homeCategory = homeData["category"] as? NSDictionary,
                            let status = homeData["status"] as? NSDictionary
                            else {return}
                            
                            var image = UIImage()
                            if let imageName = homeData["image"] as? String, let currentImage = UIImage(named: imageName){
                                image = currentImage
                            }
                            
                            let homeType = homeCategory["homeType"] as? String
                            let isForSale = status["isForSale"] as? Bool
                            
                            //Storing data in our Home entity
                            let home = homeType?.caseInsensitiveCompare("condo") == .orderedSame ? Condo(context: context) : SingleFamily(context: context)
                            
                            home.price = (price as? Double) ?? 0.00
                            home.bed = bed.int16Value
                            home.bath = bath.int16Value
                            home.sqft = sqft.int16Value
                            home.image = image.jpegData(compressionQuality: 1.0) as NSData?
                            
                            home.homeType = homeType
                            home.city = city as? String
                            home.isForSale = isForSale ?? false
                            
                            if let units = homeData["unitsPerBuilding"], home.isKind(of: Condo.self){
                                (home as! Condo).unitsPerBuilding = units.int16Value
                            }
                            
                            if let size = homeData["lotSize"], home.isKind(of: SingleFamily.self){
                                (home as! SingleFamily).lotSize = size.int16Value
                            }
                            
                            if let saleHistory = homeData["saleHistory"] as? NSArray {
                                //relationship from home to saleHistory is many to one
                               let saleHistoryData = home.saleHistory?.mutableCopy() as! NSMutableSet
                                
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
    
                                for detail in saleHistory {
                                    
                                    if let saleData = detail as? [String : AnyObject] {
                                        // Storing data in our SalesHistory entity
                                        let saleHistory = SalesHistory(context: context)
                                        
                                        if let soldPrice = saleData["soldPrice"] as? Double {
                                            saleHistory.soldPrice = soldPrice
                                        }
                                        
                                        if let soldDate = saleData["soldDate"] as? String,
                                            let soldData = formatter.date(from: soldDate) as NSDate? {
                                            saleHistory.soldDate = soldData
                                        }
                                        
                                        saleHistoryData.add(saleHistory)
                                    }
                                } //For loop Ends
                                home.addToSaleHistory(saleHistoryData.copy() as! NSSet)
                            }
                        }
                    }
                }
                coreData.saveContext()
            }
            catch{
                fatalError("can't upload data")
            }
        }
        
    }
}

