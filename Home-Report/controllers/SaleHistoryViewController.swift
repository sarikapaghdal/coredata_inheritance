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
    weak var managedObjectContext: NSManagedObjectContext!{
        didSet{
            saleHistory = SalesHistory(context: managedObjectContext)
        }
    }
    
    private var saleHistory: SalesHistory?
    // MARK - Outlet
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSoldHistory()
        
        if let homeImage = home?.image as Data? {
            let image = UIImage(data: homeImage)
            imageView.image = image
            imageView.layer.borderWidth = 1
            imageView.layer.cornerRadius = 4
        }
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
    
    private func loadSoldHistory(){
        //home can not be nil in the function argument soldHistoryData() so we use guard statement before.
        guard  let home = home , let saleHistory = saleHistory else {return}
        print(home)
        print("********")
        print(saleHistory)
        
        soldHistory = saleHistory.soldHistoryData(home: home, context: managedObjectContext)
        tableView1.reloadData()
    }
    
}
