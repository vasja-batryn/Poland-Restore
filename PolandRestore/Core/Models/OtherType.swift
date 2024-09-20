//
//  OtherType.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 17.09.2024.
//

import Foundation

enum OtherType: String {
    // MARK: - Cases

    case news = "News"
    case achievements = "Achievements"
}

// MARK: - CaseIterable

extension OtherType: CaseIterable {}

// MARK: - Identifiable

extension OtherType: Identifiable {
    var id: String { rawValue }
}
