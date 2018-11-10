//
//  ex02ViewController.swift
//  d00
//
//  Created by Sergiy SHILINGOV on 10/2/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class ex02ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    @IBAction func numOne(_ sender: UIButton) {
        numLabel.text = "1"
        print ("1")
    }
    @IBAction func numTwo(_ sender: UIButton) {
        numLabel.text = "2"
        print ("2")
    }
    @IBAction func numThree(_ sender: UIButton) {
        numLabel.text = "3"
        print ("3")
    }
    @IBAction func numFour(_ sender: UIButton) {
        numLabel.text = "4"
        print ("4")
    }
    @IBAction func numFive(_ sender: UIButton) {
        numLabel.text = "5"
        print ("5")
    }
    @IBAction func numSix(_ sender: UIButton) {
        numLabel.text = "6"
        print ("6")
    }
    @IBAction func numSeven(_ sender: UIButton) {
        numLabel.text = "7"
        print ("7")
    }
    @IBAction func numEight(_ sender: UIButton) {
        numLabel.text = "8"
        print ("8")
    }
    @IBAction func numNine(_ sender: UIButton) {
        numLabel.text = "9"
        print ("9")
    }
    
    @IBAction func numZero(_ sender: UIButton) {
        numLabel.text = "0"
        print ("0")
    }
    @IBAction func neg(_ sender: UIButton) {
        print ("change the sign of the current number")
    }
    @IBAction func ac(_ sender: UIButton) {
        print ("reset")
    }
    @IBAction func plus(_ sender: UIButton) {
        print ("plus")
    }
    @IBAction func mult(_ sender: UIButton) {
        print ("mult")
    }
    @IBAction func minus(_ sender: UIButton) {
        print ("minus")
    }
    @IBAction func divide(_ sender: UIButton) {
        print ("divide")
    }
    @IBAction func asign(_ sender: UIButton) {
        print ("asign")
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
