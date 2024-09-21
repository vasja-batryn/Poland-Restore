//
//  PersistenceController.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 19.09.2024.
//

import CoreData

struct PersistenceController {
    
    // MARK: - Public Propertis
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    // MARK: - Initializers
    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    // MARK: - Public Methods
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
