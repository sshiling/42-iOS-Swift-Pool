//
//  ArtViewController.swift
//  d09
//
//  Created by Sergiy SHILINGOV on 10/12/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import sshiling2018

class ArtViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myTitle: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var content: UITextView!
    let pickerController = UIImagePickerController()
    var articleManager : ArticleManager?
    let language = NSLocale.preferredLanguages.first
    var article: Article?
    var reloadData: Bool = false
    
    @IBAction func btPictT(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func btPictC(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btSave(_ sender: Any) {
        if myTitle.text == nil || myTitle.text == "" {
            alert(message: "Can't save without a title!")
            return
        }
        if article == nil {
            article = articleManager!.newArticle()
            article!.created_at = NSDate()
            article!.language = language
        } else {
            article!.updated_at = NSDate()
        }
        article!.title = myTitle.text
        article!.content = content.text
        if myImage.image != nil {
            article!.image = UIImagePNGRepresentation(myImage.image!)! as NSData
        }
        articleManager!.save()
        reloadData = true
        performSegue(withIdentifier: "segBack", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        
        if article != nil {
            myTitle.text = article!.title
            content.text = article!.content
            if article!.image != nil {
                myImage.image = UIImage(data: article!.image! as Data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segBack" {
            if let vc = segue.destination as? TableViewController {
                     vc.reloadData = reloadData
                }
            }
    }

}
