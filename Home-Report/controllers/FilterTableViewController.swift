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
}
