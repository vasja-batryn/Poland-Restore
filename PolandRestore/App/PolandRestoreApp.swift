//
//  PolandRestoreApp.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

@main
struct PolandRestoreApp: App {
    // MARK: - Private Properties

    @AppStorage(UserDefaultsKey.showOnboarding.rawValue)
    private var showOnboarding = true

    var body: some Scene {
        WindowGroup {
            Group {
                if showOnboarding {
                    OnboardingView()

                } else {
                    MainTabView()
                }
            }
        }
    }
}
