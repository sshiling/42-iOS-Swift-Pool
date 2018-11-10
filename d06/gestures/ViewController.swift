//
//  ViewController.swift
//  gestures
//
//  Created by Sergiy SHILINGOV on 10/10/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var viewShapes: UIView!
    var animator : UIDynamicAnimator?
    
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    let elastic = UIDynamicItemBehavior()
    let motionManager = CMMotionManager()
    
    @IBAction func top(_ sender: Any) {
        gravity.gravityDirection = CGVector(dx:0, dy: -1)
    }
    
    @IBAction func down(_ sender: Any) {
        gravity.gravityDirection = CGVector(dx:0, dy: 1)
    }
    
    @IBAction func left(_ sender: Any) {
        gravity.gravityDirection = CGVector(dx:-1, dy: 0)
    }
    
    @IBAction func right(_ sender: Any) {
        gravity.gravityDirection = CGVector(dx:1, dy: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.viewShapes)
        gravity.magnitude = 2
        elastic.elasticity = 0.9
        collision.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(gravity)
        animator?.addBehavior(collision)
        animator?.addBehavior(elastic)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
        self.viewShapes.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTapGesture(gesture: UITapGestureRecognizer)
    {
        let gestureLocation = gesture.location(in: self.viewShapes)
        let newShape = Shape(xPos: gestureLocation.x - 50, yPos: gestureLocation.y - 50)
        self.viewShapes.addSubview(newShape)
        gravity.addItem(newShape)
        collision.addItem(newShape)
        elastic.addItem(newShape)
    }
    
    func accelerometerHandler(data: CMAccelerometerData?, error: Error?) {
        if let myData = data {
            let x = CGFloat(myData.acceleration.x);
            let y = CGFloat(myData.acceleration.y);
            let v = CGVector(dx: x, dy: -y);
            gravity.gravityDirection = v;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1
            let queue = OperationQueue.main
            
            motionManager.startAccelerometerUpdates(to: queue, withHandler: accelerometerHandler )
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if motionManager.isAccelerometerAvailable {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

