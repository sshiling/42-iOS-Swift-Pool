//
//  APIController.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

class APIController {
    weak var delegate: APIIntraDelegate?
    let token: String
    var topics: [Topics] = []
    
    func convertDate(created_at: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: created_at)
        dateFormatter.dateFormat = "MM/dd/yy HH:mm"
        let dateString = dateFormatter.string(from: date!)
        return (dateString)
    }
    
    func getTopics() {
        if let url = URL(string: "https://api.intra.42.fr/v2/topics?page=1&per_page=100&access_token=" + self.token) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let group = DispatchGroup()
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let err = error {
                    print(err)
                } else if let d = data {
                    print(d)
                    do {
                        if let dic = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
                            for forum in dic {
                                let topicId = forum["id"] as! Int
                                let topicName = forum["name"] as! String
                                let author = forum["author"]! as! NSDictionary
                                let authorId = author["id"] as! Int
                                let authorLogin = author["login"] as! String
                                let topicDate = self.convertDate(created_at: forum["created_at"] as! String)
                                let tmpTopic = Topics(topicId: topicId, topicName: topicName, authorId: authorId, authorLogin: authorLogin, topicDate: topicDate)
                                self.topics.append(tmpTopic)
                            }
                            Database.topics = self.topics
                            print(self.topics)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fillData"), object: nil)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                group.leave()
            }
            group.enter()
            task.resume()
            group.wait()
            DispatchQueue.main.async {
                self.delegate?.handleTopics(topics: self.topics)
            }
        }
    }
    
    init(delegate: APIIntraDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
}
