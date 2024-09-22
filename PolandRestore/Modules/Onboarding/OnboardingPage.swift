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
    
    var title: String {
        switch self {
        case .collections:
            return "Collections right in \nyour phone!"
        case .achievements:
            return "Get achievements for \nyour collections"
        case .news:
            return "Stay tuned for more \nnews"
        }
    }
    
    var description: String {
        switch self {
        case .collections:
            return "Create your first personal \ncollection, from a wide \nvariety of items"
        case .achievements:
            return "Complete tasks, get \npersonal achievements \nfor them"
        case .news:
            return "Watch the news for your \ninterests, learn a lot of \nnew things!"
        }
    }
}

// MARK: - Identifiable

extension OnboardingPage: Identifiable {
    var id: Int { rawValue }
}
