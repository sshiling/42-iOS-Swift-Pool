//
//  MessagesTableViewCell.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var message: Messages? {
        didSet {
            messageLable.text = message!.title
            authorLabel.text = message!.author
            dateLabel.text = message!.date
        }
    }
    
    var reponses: Reponses? {
        didSet {
            messageLable.text = reponses!.replTitle
            authorLabel.text = reponses!.replAuthor
            dateLabel.text = reponses!.replDate
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
