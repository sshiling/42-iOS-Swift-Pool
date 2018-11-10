//
//  tweet.swift
//  twitter
//
//  Created by Sergiy SHILINGOV on 10/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation

struct Tweet : CustomStringConvertible {
    let name : String
    let text : String
    let date : String
    public var description: String {
        return "\(name)\n\(date)\n\(text)"
    }
}
