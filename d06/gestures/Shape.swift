//
//  Shape.swift
//  gestures
//
//  Created by Sergiy SHILINGOV on 10/10/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation
import UIKit

class Shape: UIView
{
    init(xPos: CGFloat, yPos: CGFloat) {
        super.init(frame: CGRect(x: xPos, y: yPos, width: 100.0, height: 100.0))
        self.backgroundColor = generateRandomColor()
        self.layer.cornerRadius = willBeCircle() ? 50.0 : 0;
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateRandomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func willBeCircle() -> Bool {
        let circle = drand48()
        return circle > 0.5
    }
}
