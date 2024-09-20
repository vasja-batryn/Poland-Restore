//
//  CategoryEntity+CoreDataProperties.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var categoryType: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var colections: NSSet?

}

// MARK: Generated accessors for colections
extension CategoryEntity {

    @objc(addColectionsObject:)
    @NSManaged public func addToColections(_ value: CollectionEntity)

    @objc(removeColectionsObject:)
    @NSManaged public func removeFromColections(_ value: CollectionEntity)

    @objc(addColections:)
    @NSManaged public func addToColections(_ values: NSSet)

    @objc(removeColections:)
    @NSManaged public func removeFromColections(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
