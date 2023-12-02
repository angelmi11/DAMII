//
//  Product+CoreDataProperties.swift
//  DAMII
//
//  Created by angel on 1/12/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var producToCategory: Category?

}

extension Product : Identifiable {

}
