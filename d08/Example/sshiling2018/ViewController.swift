//
//  ViewController.swift
//  sshiling2018
//
//  Created by sshiling on 10/11/2018.
//  Copyright (c) 2018 sshiling. All rights reserved.
//

import UIKit
import sshiling2018

class ViewController: UIViewController {
    
    let articlemanager = ArticleManager()
    
    @IBAction func loadArticlesAction(_ sender: Any) {
        print(articlemanager.getAllArticles())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("AM loaded")
        let art1 = articlemanager.newArticle()
        print("Art created")
        art1.title = "Art 1"
        art1.content = "Art 1 on d08"
        art1.created_at = NSDate()
        art1.updated_at = NSDate()
        art1.language = "en"
        print("before save")
        articlemanager.save()
        print("after save")
        
        let art2 = articlemanager.newArticle()
        art2.title = "Art 2"
        art2.content = "Art 2 from d08"
        art2.created_at = NSDate()
        art2.updated_at = NSDate()
        art2.language = "en"
        articlemanager.save()
        
        print(articlemanager.getAllArticles())
        print(articlemanager.getArticles(withLang: "en"))
        print(articlemanager.getArticles(containString: "on d08"))
    }

}

