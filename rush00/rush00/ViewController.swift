//
//  ViewController.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let keepGoing = #selector(ViewController.keepGoing)
    static let openUrl = #selector(ViewController.openUrl)
}

class ViewController: UIViewController, APIIntraDelegate {
    var topics: [Topics]?
    func handleTopics(topics: [Topics]) {
        self.topics = topics
    }
    
    func handleError(error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    var apiController: APIController?
    var code: String?
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: .keepGoing, name: Notification.Name("fillData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: .openUrl, name: Notification.Name("openUrl"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Database.topics = []
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("fillData"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("openUrl"), object: nil)
    }
    
@IBAction func loginIntra(_ sender: Any) {
        let myUrl = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(Database.clientID)&redirect_uri=\(Database.backLink)&response_type=code")
        UIApplication.shared.open(myUrl!)
    }
    
    @objc func keepGoing() {
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: "TopicsViewController", sender: nil)
        }
    }
    
    @objc func openUrl() {
        if let url = Database.url {
            let _ : String = url.path as String!
            let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
            for queryItem in (components?.queryItems!)! {
                if queryItem.name == "code" {
                    self.code = queryItem.value
                    getTopics()
                }
            }
        }
    }
    
    func getTopics() {
        self.getToken(self.code!)
        if let t = self.token {
            self.apiController = APIController(delegate: self, token: t)
            self.apiController?.getTopics()
        }
    }
    func getToken(_ code: String) {
        let url: String = "https://api.intra.42.fr/oauth/token"
        let params: String = "?grant_type=authorization_code&client_id=" + Database.clientID + "&client_secret=" + Database.secretID + "&code=" + code + "&redirect_uri=" + Database.backLink
        let request = NSMutableURLRequest(url: (URL(string : url + params)!))
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let group = DispatchGroup()
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if (dic["errors"] as? [Any] != nil) {
                            DispatchQueue.main.async {
                                self.handleError(error: NSError(domain: "An error has occurred while loading tweets", code: 0))
                            }
                        } else {
                            self.token = dic["access_token"] as? String
                            Database.token = self.token
                        }
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
    }
}
