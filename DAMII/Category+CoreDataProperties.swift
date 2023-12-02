//
//  Category+CoreDataProperties.swift
//  DAMII
//
//  Created by angel on 1/12/23.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var categoryToProduct: NSSet?

}

// MARK: Generated accessors for categoryToProduct
extension Category {

    @objc(addCategoryToProductObject:)
    @NSManaged public func addToCategoryToProduct(_ value: Product)

    @objc(removeCategoryToProductObject:)
    @NSManaged public func removeFromCategoryToProduct(_ value: Product)

    @objc(addCategoryToProduct:)
    @NSManaged public func addToCategoryToProduct(_ values: NSSet)

    @objc(removeCategoryToProduct:)
    @NSManaged public func removeFromCategoryToProduct(_ values: NSSet)

}

extension Category : Identifiable {

}
