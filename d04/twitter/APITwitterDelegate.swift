//
//  APITwitterDelegate.swift
//  twitter
//
//  Created by Sergiy SHILINGOV on 10/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import Foundation

protocol APITwitterDelegate {
    func treatTheTweets(name: [Tweet])
    func errorHandler(er: Error)
}
