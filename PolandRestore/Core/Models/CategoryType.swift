//
//  CategoryType.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import Foundation

enum CategoryType: String {
    // MARK: - Cases

    case old = "Old"
    case new = "New"
    case other = "Other"
}

// MARK: - CaseIterable

extension CategoryType: CaseIterable {}

// MARK: - Identifiable

extension CategoryType: Identifiable {
    var id: String { rawValue }
}
