//
//  ViewController.swift
//  d03
//
//  Created by Sergiy SHILINGOV on 05.10.2018.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let imgArray:[URL] = [
        URL(string: "https://thumbs-prod.si-cdn.com/3_jq5GkECTprO1Wp9y_ahw7kjvI=/800x600/filters:no_upscale()/https://public-media.smithsonianmag.com/filer/3b/1f/3b1f766a-d22a-4937-b099-0e96fe62b1ee/qxmjn3t6-1490887263.jp")!,
        URL(string: "https://gemr.com/wp-content/uploads/2018/05/wp-1487634304655-2.png")!,
        URL(string: "https://d1jo0zet24jmxt.cloudfront.net/content/5494/lALaxxUVJoZMeRcW3HfvG7QoDua.jpg")!,
        URL(string: "https://i.pinimg.com/originals/f5/6a/04/f56a044425e23c55ee5f133cf74b742a.jpg")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Images"
        
        let itemSize = UIScreen.main.bounds.width/2 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 5, 10, 5)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        myCollectionView.collectionViewLayout = layout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seq = segue.destination as! ScrollViewController
        let cell = sender! as! myCell
        if let img = cell.myImageView.image {
            seq.image = img
        } else {
            let alertController = UIAlertController(title: "Error", message: "Cannot acces to this image", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    // Number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    // Populate view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        let imgUrl = imgArray[indexPath.row]
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imgUrl)
            if data == nil {
                let urlName = self.imgArray[indexPath.row]
                
                let alertController = UIAlertController(title: "Error", message: "Cannot acces to \(urlName)", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    cell.loader.hidesWhenStopped = true
                    cell.loader.stopAnimating()
                    cell.myImageView.image = UIImage(data: data!)
                }
            }
        }
        
        cell.loader.startAnimating()
        cell.loader.color = (UIColor.white)
        cell.layer.borderColor = (UIColor.black.cgColor)
        cell.layer.backgroundColor = (UIColor.black.cgColor)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
}

