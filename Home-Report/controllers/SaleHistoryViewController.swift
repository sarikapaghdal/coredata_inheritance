//
//  SaleHistoryViewController.swift
//  Home Report
//
//  Created by Sarika on 22/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit
import CoreData

class SaleHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Property
    private lazy var soldHistory = [SalesHistory]()
    var home: Home?
    weak var managedObjectContext: NSManagedObjectContext!
    
    // MARK - Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: Tableview datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soldHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! SaleHistoryTableViewCell
        
        let saleHistory = soldHistory[indexPath.row]
        cell.configureCell(saleHistory: saleHistory)
        
        return cell
    }
}
