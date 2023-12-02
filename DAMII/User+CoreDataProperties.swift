//
//  User+CoreDataProperties.swift
//  DAMII
//
//  Created by angel on 1/12/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
