//
//  Double+Extension.swift
//  Home-Report
//
//  Created by Sarika on 21/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import Foundation

extension Double{

    var currencyFormatter : String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self))!
    }
}

