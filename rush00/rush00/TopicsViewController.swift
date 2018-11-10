//
//  TopicsViewController.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {
    

    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //count = 0
        //setupInitialSettings()
        
        addButton.layer.borderWidth = 0.5
        addButton.layer.borderColor = UIColor.white.cgColor
        addButton.layer.cornerRadius = 5
        
        tableViewTopConstraint.constant = 0
    }
//    func setupInitialSettings() {
//        DatabaseManager.messages = [Messages]()
//        background.isHidden = true
//        activityIndicator.isHidden = true
//
//        activityIndicator.startAnimating()
//    }
    func setupNavBarSettings() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchRightBarButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.navigationItem.title = "Topics"
    }
    
    @objc func touchRightBarButtonItem() {
        UIView.animate(withDuration: 5) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.tableViewTopConstraint.constant = strongSelf.addView.frame.height
        }
    }
    
    @IBAction func touchAddButton(_ sender: UIButton) {
        UIView.animate(withDuration: 5) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.tableViewTopConstraint.constant = 0
        }
    }
    
}

extension TopicsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database.topics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell", for: indexPath) as! TopicTableViewCell
        cell.topic = Database.topics[indexPath.row]
    
        return (cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "MessageViewController",
            let destination = segue.destination as? MessageViewController,
            let row = tableView.indexPathForSelectedRow?.row
        {
            destination.topic = Database.topics[row].topicId
        }
    }
    
}
