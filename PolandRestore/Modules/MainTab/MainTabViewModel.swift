//
//  MainTabViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import Foundation

@MainActor
final class MainTabViewModel: ObservableObject {
    // MARK: - Public Propertis

    @Published var selectedTab = 0
    let tabs = Tab.allCases
}
