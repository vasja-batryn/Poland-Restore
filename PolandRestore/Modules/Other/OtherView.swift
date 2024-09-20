//
//  OtherView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct OtherView: View {
    // MARK: - Private Properties

    @StateObject private var viewModel = OtherViewModel()
    @ObservedObject private var userManager = UserManager.shared

    var body: some View {
        NavigationStack {
            VStack {
                Text("Other")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.primaryForeground)
                    .frame(maxWidth: .infinity, alignment: .leading)

                OtherPicker(
                    selectedTab: $viewModel.selectedPickerTab,
                    types: viewModel.otherTypes
                )

                if viewModel.selectedPickerTab == .news {
                    ScrollView {
                        ForEach(viewModel.cards) { card in
                            NewsCard(
                                card: card,
                                onTapCard: {
                                    viewModel.presentNews = true
                                    viewModel.selectedNews = card
                                }
                            )
                        }
                    }
                } else {
                    ScrollView {
                        ForEach(viewModel.achievements, id: \.self) { achievement in
                            AchievementsCard(
                                achievements: achievement,
                                progress: .constant(viewModel.progressValues[achievement] ?? 0),
                                collectionCount: userManager.user?.collectionCount ?? 0
                            )
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $viewModel.presentNews) {
                NewsView(new: viewModel.selectedNews)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("News")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundStyle(.primaryForeground)
                                    .frame(maxWidth: .infinity)
                                    .overlay(alignment: .leading) {
                                        Button(action: { viewModel.presentNews.toggle() }) {
                                            HStack {
                                                Image(systemName: "chevron.left")
                                                    .font(.system(size: 12, weight: .medium))
                                                    .foregroundStyle(.primaryForeground)

                                                Text("Back")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundStyle(.primaryForeground)
                                            }
                                        }
                                    }
                            }
                        }
                    }
            }
        }
        .onAppear {
            viewModel.updateAchievementProgress(collectionCount: UserManager.shared.user?.collectionCount ?? 0)
        }
    }
}

#Preview {
    OtherView()
}
