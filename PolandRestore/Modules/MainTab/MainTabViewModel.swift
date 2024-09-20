//
//  MainTabViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import Foundation

@MainActor
final class MainTabViewModel: ObservableObject {
    let tabs = Tab.allCases
    @Published var selectedTab = 0
}
