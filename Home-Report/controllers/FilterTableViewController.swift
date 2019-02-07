//
//  FilterTableViewController.swift
//  Home Report
//
//  Created by Sarika on 22/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit

protocol FilterTableViewControllerDelegate: class {
    func updateHomeList(filterby: NSPredicate?, sortby: NSSortDescriptor?)
}

class FilterTableViewController: UITableViewController {

    // SORT BY
    @IBOutlet weak var sortByLocationCell: UITableViewCell!
    @IBOutlet weak var sortByPriceLowHighCell: UITableViewCell!
    @IBOutlet weak var sortByPriceHighLowCell: UITableViewCell!
    
    // FILTER by home type
    @IBOutlet weak var filterByCondoCell: UITableViewCell!
    @IBOutlet weak var filterBySingleFamilyCell: UITableViewCell!
    
    private var sortDescriptor : NSSortDescriptor?
    private var searchPredicate : NSPredicate?
    weak var delegate : FilterTableViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath){
            
            switch selectedCell{
                
            case sortByLocationCell:
                setSortDescriptor(sortBy: "city", isAsc: true)
                
            case sortByPriceLowHighCell:
               setSortDescriptor(sortBy: "price", isAsc: true)
                
            case sortByPriceHighLowCell:
                setSortDescriptor(sortBy: "price", isAsc: false)
                
            case filterByCondoCell, filterBySingleFamilyCell :
                setFilterSearchPredicate(filterBy: (selectedCell.textLabel?.text)!)
      
            default:
                break
            }
            
            selectedCell.accessoryType = .checkmark
            delegate.updateHomeList(filterby: searchPredicate, sortby: sortDescriptor)
        }
    }
    
    private func setSortDescriptor(sortBy: String, isAsc : Bool) {
        sortDescriptor = NSSortDescriptor(key: sortBy, ascending: isAsc)
    }
    
    private func setFilterSearchPredicate(filterBy: String) {
        searchPredicate = NSPredicate(format: "homeType = '\(filterBy)'")
    }
    
}
