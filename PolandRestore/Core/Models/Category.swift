//
//  Category.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 19.09.2024.
//

import SwiftUI

struct Category: Identifiable {
    // MARK: - Public Propertis

    var id: UUID = .init()
    var name: String
    var image: UIImage?
    var categoryType: CategoryType
    var colections: [Collection]?
}

struct Collection: Identifiable {
    // MARK: - Public Propertis

    var id: UUID = .init()
    var name: String
    var image: UIImage?
    var cost: String
    var year: String
    var categoryType: CategoryType
}
