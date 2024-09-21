//
//  MainTabView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct MainTabView: View {
    // MARK: - Private Properties

    @StateObject private var viewModel = MainTabViewModel()

    @State private var completedAchievement: AchievementType?
    @State private var showToast = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $viewModel.selectedTab) {
                    OtherView()
                        .tag(0)

                    HomeView()
                        .tag(1)

                    SettingsView()
                        .tag(2)
                }

                ZStack {
                    HStack(spacing: 90) {
                        ForEach(viewModel.tabs, id: \.self) { item in
                            Button {
                                viewModel.selectedTab = item.rawValue
                            } label: {
                                CustomTabItem(imageName: item.iconName, title: item.title, isActive: viewModel.selectedTab == item.rawValue)
                            }
                        }
                    }
                }
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(.primaryForeground)
            }
            .toastMessage(completedAchievement ?? .createFirst, isPresented: $showToast)
            .onChange(of: OtherViewModel.shared.completedAchievement) { newAchievement in
                if let achievement = newAchievement {
                    completedAchievement = achievement
                    showToast = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        OtherViewModel.shared.resetCompletedAchievement()
                    }
                }
            }
            .onAppear {
                if let achievement = OtherViewModel.shared.completedAchievement {
                    completedAchievement = achievement
                    showToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        OtherViewModel.shared.resetCompletedAchievement()
                    }
                }
            }
        }
    }
}

extension MainTabView {
    // MARK: - Public Methods

    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        VStack {
            Image(imageName)
                .resizable()
                .foregroundColor(isActive ? .primaryForeground : .primaryText)
                .frame(width: 32, height: 32)

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(isActive ? .primaryForeground : .primaryText)
        }
        .frame(width: 60, height: 60)
        .background(isActive ? .primaryText : .clear)
        .cornerRadius(12)
    }
}

#Preview {
    MainTabView()
}
