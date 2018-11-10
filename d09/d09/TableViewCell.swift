//
//  TableViewCell.swift
//  d09
//
//  Created by Sergiy SHILINGOV on 10/12/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var updated_at: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
