//
//  TableViewController.swift
//  d09
//
//  Created by Sergiy SHILINGOV on 10/12/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import sshiling2018

class TableViewController: UITableViewController {

    let language = NSLocale.preferredLanguages.first
    let articleManager = ArticleManager()
    var articles: [Article] = []
    var reloadData: Bool = false
    var articleDel: Article? = nil
    
    @IBOutlet var tabArticle: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabArticle.delegate = self
        tabArticle.dataSource = self
        print("lang \(String(describing: language))")
        loadArticles()
        tabArticle.rowHeight = UITableViewAutomaticDimension
        tabArticle.estimatedRowHeight = 140
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return articles.count
    }
    
    func loadArticles() {
        articles = []
        articles = articleManager.getArticles(withLang: language!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellArt", for: indexPath) as! TableViewCell
        cell.myTitle.text = articles[indexPath.row].title
        if articles[indexPath.row].image != nil {
            let i = UIImage(data: articles[indexPath.row].image! as Data)
            cell.myImage.image = i
            cell.myImage.isHidden = false
        } else {
            cell.myImage.isHidden = true
        }
        cell.content.text = articles[indexPath.row].content
        let d = DateFormatter()
        d.locale = Locale(identifier: language!)
        d.setLocalizedDateFormatFromTemplate("MMM dd, YYYY 'at' HH:mm")
        cell.created_at.text = "Creation: \(d.string(from: articles[indexPath.row].created_at! as Date))"
        if articles[indexPath.row].updated_at != nil {
            cell.updated_at.text = "Modification: \(d.string(from: articles[indexPath.row].updated_at! as Date))"
            cell.updated_at.isHidden = false
        } else {
            cell.updated_at.isHidden = true
        }
        return cell
    }
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segMod", sender: indexPath.row)
    }

      @IBAction func unWindsegue(segue: UIStoryboardSegue) {
        print("back seg Reload data? \(reloadData)")
        if reloadData {
            print("reload")
            loadArticles()
            tabArticle.reloadData()
        }
     }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segMod" {
            if let vc = segue.destination as? ArtViewController {
                let row = sender as! Int
                vc.articleManager = articleManager
                print(articles[row].title!)
                vc.article = articles[row]
            }
        } else if segue.identifier == "segCrea" {
            if let vc = segue.destination as? ArtViewController {
                vc.articleManager = articleManager
            }
        }
    }
    
    // Swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            articleDel = articles[indexPath.row]
            confirmDelete(article: articleDel!.title!)
 
        }
    }
    
    func confirmDelete(article: String) {
        let alert = UIAlertController(title: "Delete article", message: "Are you sure you want to permanently delete \(article)?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteArticle)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteArticle)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    func handleDeleteArticle(alertAction: UIAlertAction!) -> Void {
        articleManager.removeArticle(article: articleDel!)
        loadArticles()
        tabArticle.reloadData()
        articleDel = nil
     }
    func cancelDeleteArticle(alertAction: UIAlertAction!) {
        articleDel = nil
    }
}
