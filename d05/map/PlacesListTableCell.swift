//
//  PlacesListTableCell.swift
//  map
//
//  Created by Sergiy SHILINGOV on 10/8/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation

import UIKit

class PlacesListTableCell: UITableViewCell {
    
    @IBOutlet weak var placeLabel: UILabel!
    
    var place : (Double, Double, String, String, String)? {
        didSet {
            if let p = place {
                placeLabel?.text = p.2
//                title = p.1
//                subtitle = p.2
            }
        }
    }
}
