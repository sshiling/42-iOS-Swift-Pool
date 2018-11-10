//
//  ViewController.swift
//  pods
//
//  Created by Sergiy SHILINGOV on 10/10/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController {
    var bot : RecastAIClient?
    let client = DarkSkyClient(apiKey: "088bd2f19b5eee80c667fb4277f6a779")
    
    @IBOutlet weak var requestField: UITextField!
    @IBAction func requestBtn(_ sender: UIButton) {
        if !(requestField.text?.isEmpty)! && requestField.text!.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            makeRequest()
        } else {
            responseField.text = "Please, input request text"
        }
    }
    @IBOutlet weak var responseField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bot = RecastAIClient(token : "89b3d89f42c27083c72d304b25e2e9b6")
        client.language = .english
        client.units = .si
    }

    func makeRequest()
    {
        //Call makeRequest with string parameter to make a text request
        self.bot?.textRequest(requestField.text!, successHandler: { (resp) in
            print(resp)
            print(resp.intents?.description)
            var loc = resp.get(entity: "location")
            if loc != nil {
                print(loc!["formatted"])
                self.responseField.text = loc!["formatted"] as! String
                
//              TODO   my_string.trimmingCharacters(in: .whitespacesAndNewlines)
                
                self.client.getForecast(latitude: loc!["lat"] as! Double, longitude: loc!["lng"] as! Double) { result in
                    print(result)
                    switch result {
                    case .success(let currentForecast, let requestMetadata):
                        print(currentForecast.daily?.summary!)
                        DispatchQueue.main.async {
                            self.responseField.text = "\(self.responseField.text!)\n\(currentForecast.daily!.summary!)"
                            self.requestField.text = ""
                        }
                    case .failure(let error):
                        print("Uh-oh. We have an error!")
                        DispatchQueue.main.async {
                            self.responseField.text = "Uh-oh. We have an error!"
                        }
                    }
                }
            } else {
                print("No such location")
                self.responseField.text = "No such location. Try again!"
            }
        }, failureHandle: { (error) in
            print("Error")
            self.responseField.text = "Error"
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

