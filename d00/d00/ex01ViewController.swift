//
//  ex01ViewController.swift
//  d00
//
//  Created by Sergiy SHILINGOV on 10/2/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class ex01ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBAction func clickBtn(_ sender: UIButton) {
        label.text = "Hello World !"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
