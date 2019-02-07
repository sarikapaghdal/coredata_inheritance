//
//  SummaryTableViewController.swift
//  Home Report
//
//  Created by Sarika on 22/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit
import CoreData

class SummaryTableViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var totalSalesDollarLabel: UILabel!
    @IBOutlet weak var numCondoSoldLabel: UILabel!
    @IBOutlet weak var numSFSoldLabel: UILabel!
    @IBOutlet weak var minPriceHomeLabel: UILabel!
    @IBOutlet weak var maxPriceHomeLabel: UILabel!
    @IBOutlet weak var avgPriceCondoLabel: UILabel!
    @IBOutlet weak var avgPriceSFLabel: UILabel!
    
    
    // MARK: Properties
    private var home: Home?
    
    weak var managedObjectContext: NSManagedObjectContext! {
        didSet {
            return home = Home(context: managedObjectContext)
        }
    }
    
    private var soldPredicate: NSPredicate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let home = home { //for $ sign we use currencyFormatter
            totalSalesDollarLabel.text = "\(home.totalSoldHomeValues(moc: managedObjectContext).currencyFormatter)"
            numCondoSoldLabel.text = "\(home.totalSoldCondo(moc: managedObjectContext))"
            numSFSoldLabel.text = "\(home.totalSoldFamily(moc: managedObjectContext))"
            minPriceHomeLabel.text =  "\(home.soldPrice(priceType: "min", moc: managedObjectContext).currencyFormatter)"
            maxPriceHomeLabel.text =  "\(home.soldPrice(priceType: "max", moc: managedObjectContext).currencyFormatter)"
            avgPriceCondoLabel.text = "\(home.averagePrice(homeType: .Condo, moc: managedObjectContext))"
            avgPriceSFLabel.text = "\(home.averagePrice(homeType: .SingleFamily, moc: managedObjectContext))"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        
        switch section {
        case 0:
            rowCount = 3
        case 1, 2:
            rowCount = 2
        default:
            rowCount = 0
        }
        
        return rowCount
    }
}
