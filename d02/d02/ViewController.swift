//
//  ViewController.swift
//  d02
//
//  Created by Sergiy SHILINGOV on 10/3/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deathTable: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.names.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! DeathTableViewCell
        cell.name = Data.names[indexPath.row]
        cell.nameLabel?.numberOfLines = 0
        cell.descriptionLabel?.numberOfLines = 0
        cell.dateLabel?.numberOfLines = 0
        deathTable.rowHeight = UITableViewAutomaticDimension
        deathTable.estimatedRowHeight = 44
        
//        cell?.textLabel?.text = Data.names[indexPath.row].0
//        cell?.detailTextLabel?.text = Data.names[indexPath.row].1
//        return cell!
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

