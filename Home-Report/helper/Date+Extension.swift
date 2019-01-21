//
//  Date+Extension.swift
//  Home-Report
//
//  Created by Sarika on 21/01/19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: self)
    }
}
