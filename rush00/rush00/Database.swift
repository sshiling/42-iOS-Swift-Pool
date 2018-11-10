//
//  Database.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

struct Database {
    
    static var topics = [Topics]()
    static var messages = [Messages]()
    static var url: URL?
    static var token: String?
    static let clientID = "a57071ca4bfbcdf566b9bf7ad4f21a2406535346e7f19d9deb2cbae2066cb065"
    static let secretID = "abd086bd4ed7097289e6e4053ab418532a4d0add8145c425a6d37c02aa42d387"
    static let backLink = "Rush00%3A%2F%2FRush00"
}
