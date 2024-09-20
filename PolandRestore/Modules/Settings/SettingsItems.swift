//
//  SettingsItems.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

enum SettingsItem: String, CaseIterable {
    // MARK: - Cases

    case termOfUse
    case privacyPolicy
    case support

    // MARK: - Public Properties

    var image: String {
        return "\(self.rawValue)"
    }
}

// MARK: - CustomStringConvertible

extension SettingsItem: CustomStringConvertible {
    var description: String {
        switch self {
        case .termOfUse:
            return "Terms of use"
        case .privacyPolicy:
            return "Privacy Policy"
        case .support:
            return "Support page"
        }
    }
}

// MARK: - Identifiable

extension SettingsItem: Identifiable {
    var id: String { rawValue }
}
