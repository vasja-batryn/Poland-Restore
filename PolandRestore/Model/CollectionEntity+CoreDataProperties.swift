//
//  CollectionEntity+CoreDataProperties.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//
//

import Foundation
import CoreData


extension CollectionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CollectionEntity> {
        return NSFetchRequest<CollectionEntity>(entityName: "CollectionEntity")
    }

    @NSManaged public var categoryType: String?
    @NSManaged public var cost: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var year: String?
    @NSManaged public var category: CategoryEntity?

}

extension CollectionEntity : Identifiable {

}
