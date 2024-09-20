//
//  Tab.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import Foundation

enum Tab: Int {
    // MARK: - Cases

    case news = 0
    case home
    case settings

    // MARK: - Public Properties

    var title: String {
        switch self {
        case .news:
            return "News"
        case .home:
            return "Home"
        case .settings:
            return "Settings"
        }
    }

    var iconName: String {
        switch self {
        case .news:
            return "news"
        case .home:
            return "home"
        case .settings:
            return "settings"
        }
    }
}

// MARK: - CaseIterable

extension Tab: CaseIterable {}

// MARK: - Hashable

extension Tab: Hashable {}
