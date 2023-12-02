//
//  BranchOffice+CoreDataProperties.swift
//  DAMII
//
//  Created by DAMII on 2/12/23.
//
//

import Foundation
import CoreData


extension BranchOffice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BranchOffice> {
        return NSFetchRequest<BranchOffice>(entityName: "BranchOffice")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var branchOfficeToUser: NSManagedObject?

}

extension BranchOffice : Identifiable {

}
