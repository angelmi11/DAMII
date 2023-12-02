//
//  Vendor+CoreDataProperties.swift
//  DAMII
//
//  Created by angel on 1/12/23.
//
//

import Foundation
import CoreData


extension Vendor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vendor> {
        return NSFetchRequest<Vendor>(entityName: "Vendor")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lastName: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?

}

extension Vendor : Identifiable {

}
