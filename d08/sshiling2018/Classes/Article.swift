//
//  Article+CoreDataClass.swift
//  Pods-sshiling2018_Example
//
//  Created by Sergiy SHILINGOV on 10/11/18.
//
//

import Foundation
import CoreData


public class Article: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: NSData?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var updated_at: NSDate?
    
    override public var description: String {
        return "\(title!)\n\(content!)\n\(language!)\n\(created_at!)\n\(updated_at!)"
    }
    
}
