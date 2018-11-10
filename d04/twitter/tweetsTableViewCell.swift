//
//  tweetsTableViewCell.swift
//  twitter
//
//  Created by Sergiy SHILINGOV on 10/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class tweetsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet : (String, String, String)? {
        didSet {
            if let t = tweet {
                nameLabel?.text = t.0
                dateLabel?.text = t.1
                tweetTextLabel?.text = t.2
            }
        }
    }
}
