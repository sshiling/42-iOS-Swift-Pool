//
//  TopicTableViewCell.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicName: UILabel!
    @IBOutlet weak var topicAuthor: UILabel!
    @IBOutlet weak var topicDate: UILabel!
    
    var topic: Topics? {
        didSet {
            topicName.text = topic!.topicName
            topicAuthor.text = topic!.authorLogin
            topicDate.text = topic!.topicDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
