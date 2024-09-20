//
//  AchievementType.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import Foundation

enum AchievementType: String {
    // MARK: - Cases

    case createFirst = "Create your first collection\n"
    case createThree = "Create 3 categories with at least \n1 collections"
    case createFive = "Create 5 categories with at least \n3 collections"
    case createNine = "Create 9 categories with at least \n5 collections"
}

// MARK: - CaseIterable

extension AchievementType: CaseIterable {}

// MARK: - Identifiable

extension AchievementType: Identifiable {
    var id: String { rawValue }
}
