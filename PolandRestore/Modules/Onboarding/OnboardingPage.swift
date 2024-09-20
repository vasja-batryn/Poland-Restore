//
//  OnboardingPage.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

enum OnboardingPage: Int, CaseIterable {
    // MARK: - Cases

    case collections = 1
    case achievements
    case news

    // MARK: - Public Properties

    var image: String {
        "Onboarding-\(rawValue)"
    }
}

// MARK: - Identifiable

extension OnboardingPage: Identifiable {
    var id: Int { rawValue }
}
