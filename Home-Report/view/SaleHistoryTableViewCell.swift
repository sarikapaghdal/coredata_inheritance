//
//  SaleHistoryTableViewCell.swift
//  Home Report
//
//  Created by Sarika on 22/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit

class SaleHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var soldDateLabel1: UILabel!
    @IBOutlet weak var soldPriceLabel1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(saleHistory: SalesHistory) {
        soldDateLabel1.text = (saleHistory.soldDate as Date?)?.toString
        soldPriceLabel1.text = saleHistory.soldPrice.currencyFormatter
    }

}
