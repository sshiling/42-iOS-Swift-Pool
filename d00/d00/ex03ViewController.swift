//
//  ex03ViewController.swift
//  d00
//
//  Created by Sergiy SHILINGOV on 10/2/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class ex03ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var oper = false;
    var act = false;
    var type = 0;
    var val1:Int = 0;
    var val2:Int = 0;
    
    @IBAction func numbers(_ sender: UIButton) {
        if (oper) {
            oper = false;
            val1 = 0;
            
            if (type == 16) {
                val2 = 0;
            }
            else {
                act = true;
            }
        }
        if ((val1 >= 0 && (val1 * 10 + sender.tag) < 2147483648) || (val1 < 0 && (val1 * 10 - sender.tag) > -2147483649)) {
            if (val1 < 0) {
                val1 = val1 * 10 - sender.tag;
            }
            else {
                val1 = val1 * 10 + sender.tag;
            }
        }
        else {
            if (val1 >= 0) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else {
                val1 = -2147483648;
                print("Error : min Int");
            }
        }
        label.text = String(val1);
    }
    
    func actions() {
        if (type == 12) {
            if (val1 + val2 > 2147483647) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else if (val1 + val2 < -2147483648) {
                val1 = -2147483648;
                print("Error : min Int");
            }
            else {
                val1 = val1 + val2;
            }
        }
        else if (type == 13) {
            if (val1 * val2 > 2147483647) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else if (val1 * val2 < -2147483648) {
                val1 = -2147483648;
                print("Error : min Int");
            }
            else {
                val1 = val1 * val2;
            }
        }
        else if (type == 14) {
            if (val2 - val1 > 2147483647) {
                val1 = 2147483647;
                print("Error : max Int");
            }
            else if (val2 - val1 < -2147483648) {
                val1 = -2147483648;
                print("Error : min Int");
            }
            else {
                val1 = val2 - val1;
            }
        }
        else if (type == 15) {
            val1 = val2 / val1;
        }
        label.text = String(val1);
    }
    
    @IBAction func operations(_ sender: UIButton) {
        oper = true;
        if (act || sender.tag == 16) {
            if (type == 15 && val1 == 0) {
                label.text = "Error";
                val1 = 0;
                val2 = 0;
                type = 0;
                act = false;
                oper = false;
            }
            else {
                actions();
            }
            act = false;
            val2 = val1;
        }
        else {
            val2 = val1;
        }
        type = sender.tag;
    }
    
    @IBAction func AcOp(_ sender: UIButton) {
        val1 = 0;
        val2 = 0;
        label.text = "0";
        type = 0;
        act = false;
        oper = false;
    }
    
    @IBAction func negOp(_ sender: UIButton) {
        if ((val1 < 0 && val1 * -1 < 2147483648) || (val1 >= 0 && val1 * -1 > -2147483649)) {
            val1 = -val1;
        }
        else {
            if (val1 < 0) {
                val1 = 2147483647;
            }
            else {
                val1 = -2147483648;
            }
            print("Error : max or min Int");
        }
        label.text = String(val1);
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
