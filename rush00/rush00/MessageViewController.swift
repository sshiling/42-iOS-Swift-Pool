//
//  MessageViewController.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var topic: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (topic != nil) {
            getMessages(topicID: topic!) { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func getMessages(topicID : Int, completion: (() ->())?) {
        let url = "https://api.intra.42.fr/v2/topics/\(topicID)/messages?access_token=" + Database.token!
        let request = NSMutableURLRequest(url: (URL(string : url))!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as! [NSDictionary] {
                        var messages : [Messages] = []
                        for message in json {
                            let id: Int! = message["id"] as! Int
                            let content: String! = message["content"] as! String
                            let user = message["author"]! as! NSDictionary
                            let userName : String! = user["login"] as! String
                            let userID: Int! = user["id"] as! Int
                            let date: String! =  message["created_at"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            let date2 = dateFormatter.date(from: date!)
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                            let newDate = dateFormatter.string(from: date2!)
                            
                            var replies : [Reponses] = []
                            var repl: Bool = false
                            if message["replies"] != nil {
                                repl = true
                                for reply in message["replies"] as! [[String : Any]] {
                                    let messID = id as Int
                                    let replID = reply["id"] as! Int
                                    let replTitle = reply["content"] as! String
                                    let replAuthorArr = reply["author"]! as! NSDictionary
                                    let replAuthorName = replAuthorArr["login"] as! String
                                    let replAuthorID = replAuthorArr["id"] as! Int
                                    let replDate = reply["created_at"] as! String
                                    
                                    replies.append(Reponses(messID: messID,
                                                            replID: replID,
                                                            replTitle: replTitle,
                                                            replAuthor: replAuthorName,
                                                            replAuthorID: replAuthorID,
                                                            replDate: replDate))
                                }
                            }
                            messages.append(Messages(id: id,
                                                     title: content,
                                                     author : userName,
                                                     authorID: userID,
                                                     date: newDate,
                                                     replBool: repl,
                                                     replies: replies))
                        }
                        Database.messages = messages
                        print(messages)
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }

}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as! MessagesTableViewCell
        cell.message = Database.messages[indexPath.row]
        return (cell)
    }
}
