//
//  TweetsTableViewController.swift
//  twitter
//
//  Created by Sergiy SHILINGOV on 10/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class TweetsTableViewController: UITableViewController, APITwitterDelegate, UITextFieldDelegate, UISearchBarDelegate {
    @IBOutlet var tweeterTable: UITableView!
    
    var allTweets : [Tweet] = []
    var newSearchBar: UISearchBar!
    var tokenGlobal : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Tweets"
        createConnection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allTweets.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! tweetsTableViewCell
            cell.searchField.placeholder = "Search"
            self.newSearchBar = cell.searchField
            self.newSearchBar.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! tweetsTableViewCell
            cell.tweet = (allTweets[indexPath.row - 1].name, allTweets[indexPath.row - 1].date, allTweets[indexPath.row - 1].text)
            
            cell.nameLabel?.numberOfLines = 0
            cell.dateLabel?.numberOfLines = 0
            cell.tweetTextLabel?.numberOfLines = 0
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 44
            return cell
        }
    }
    
    func treatTheTweets(name: [Tweet]) {
        DispatchQueue.main.async {
            self.allTweets = name
            self.tweeterTable.reloadData()
        }
    }
    
    func errorHandler(er: Error) {
        print(er)
    }
    
//    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let a = APIController(delegate: self as APITwitterDelegate, token: tokenGlobal)
//        if (searchBar.text?.characters.count)! > 0 {
//            a.queryRequest(dict: searchBar.text!)
//        }
//        else {
//            a.queryRequest(dict: "school 42")
//        }
//    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let a = APIController(delegate: self as APITwitterDelegate, token: tokenGlobal)
//        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        if (searchBar.text?.count)! > 0 {
            a.queryRequest(dict: searchBar.text!)
        }
        else {
            a.queryRequest(dict: "school 42")
        }
    }
    
    func twitterAuth() -> String {
        let CUSTUMER_KEY = "Xdoz0kpNz79Cw1X5CaVGoc6EA"
        let CUSTUMER_SECRET = "GTQSXO9EamEVPSdUtM4SDPFiE7l6d9MdYXIGJgMurnqbcljJAN"
        let BEARER = ((CUSTUMER_KEY + ":" + CUSTUMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return BEARER
    }
    
    func createConnection() {
        // Создание ключа для подключения
        let key = twitterAuth()
        
        // Создание запроса для подключения
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + key, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        // Выполнение запроса для подключения
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    let dic: Dictionary = try JSONSerialization.jsonObject(with: d, options: []) as! [String:Any]
                    
                    // Делаем запрос через APIController
                    let a = APIController(delegate: self as APITwitterDelegate, token: (dic["access_token"] as? String)!)
                    self.tokenGlobal = a.token
                    a.queryRequest(dict: "school 42")
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
}
