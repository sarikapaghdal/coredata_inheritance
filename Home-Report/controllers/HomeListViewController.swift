//
//  HomeListViewController.swift
//  Home Report
//
//  Created by Sarika on 22/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit
import CoreData

class HomeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    weak var managedObjectContext: NSManagedObjectContext! {
        didSet {
            return home = Home(context: managedObjectContext)
        }
    }
    
    private lazy var homes = [Home]()
    private var selectedHome: Home?
    private var home: Home?
    private var isForSale: Bool = true
    private var sortDescriptor = [NSSortDescriptor]()
    private var searchPredicate: NSPredicate?
    private var request: NSFetchRequest<Home> = Home.fetchRequest()
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Segmented control
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
        isForSale = selectedValue == "For Sale" ? true : false
        loadData()
    }
    
    // MARK: TableView datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeListTableViewCell
        
        let currentHome = homes[indexPath.row]
        cell.configureCell(home: currentHome)
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "segueHistory":
            
            let destination = segue.destination as! SaleHistoryViewController
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let selectedHome = homes[selectedIndexPath.row]
                destination.home = selectedHome
                destination.managedObjectContext = managedObjectContext
            }
        case "segueToFilter":
            sortDescriptor = []
            searchPredicate = nil
            let destination = segue.destination as! FilterTableViewController
            destination.delegate = self
            
        default:
            break
        }
    }
    
    private func loadData() {
        if let arrHomes = home?.gethomeByStatus(isForSale: isForSale, filter: searchPredicate, sort: sortDescriptor, context: managedObjectContext){
            homes = arrHomes
            tableView.reloadData()
        }
    }
}

extension HomeListViewController : FilterTableViewControllerDelegate {
    //user will select either predicate or sortby so they are optionals
    func updateHomeList(filterby: NSPredicate?, sortby: NSSortDescriptor?) {
        if let filter = filterby {
            searchPredicate = filter
        }
        
        if let sort = sortby {
            sortDescriptor.append(sort)
        }
    }
    
    
}
