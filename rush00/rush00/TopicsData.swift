//
//  TopicsData.swift
//  rush00
//
//  Created by Yaroslav Zakharchuk on 10/7/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import Foundation

struct Topics : CustomStringConvertible {
    var topicId : Int
    var topicName : String
    var authorId : Int
    var authorLogin : String
    var topicDate : String
    
    var description: String {
        return "\(topicId)\n\(topicName)\n\(authorId)\n\(authorLogin)\n\(topicDate)"
    }
    
    init(topicId: Int, topicName: String, authorId: Int, authorLogin: String, topicDate: String) {
        self.topicId = topicId
        self.topicName = topicName
        self.authorId = authorId
        self.authorLogin = authorLogin
        self.topicDate = topicDate
    }
}

protocol APIIntraDelegate: class {
    func handleTopics(topics: [Topics])
    func handleError(error: Error)
}

struct Messages: CustomStringConvertible {
    var id : Int
    var title : String
    var author : String
    var authorID : Int
    var date : String
    var replBool : Bool
    var replies : [Reponses]
    
    public var description: String {
        return "\(id)\n\(title)\n\(author)\n\(date)"
    }
    
    init(id: Int, title: String, author: String, authorID: Int, date: String, replBool: Bool, replies: [Reponses]) {
        self.id = id
        self.title = title
        self.author = author
        self.authorID = authorID
        self.date = date
        self.replBool = replBool
        self.replies = replies
    }
}

struct Reponses : CustomStringConvertible {
    var messID : Int
    var replID : Int
    var replTitle : String
    var replAuthor : String
    var replAuthorID : Int
    var replDate : String
    
    public var description: String {
        return "\(replID)\n\(replTitle)\n\(replAuthor)\n\(replDate)"
    }
    
    init(messID: Int, replID: Int, replTitle: String, replAuthor: String, replAuthorID: Int, replDate: String) {
        self.messID = messID
        self.replID = replID
        self.replTitle = replTitle
        self.replAuthor = replAuthor
        self.replAuthorID = replAuthorID
        self.replDate = replDate
    }
}
