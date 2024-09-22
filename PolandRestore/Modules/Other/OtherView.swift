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

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                headerView
                OtherPicker(
                    selectedTab: $viewModel.selectedPickerTab,
                    types: viewModel.otherTypes
                )
                .padding(.bottom)
                contentView
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $viewModel.presentNews) {
                newsDetailView
            }
        }
        .onAppear {
            viewModel.updateAchievementProgress(collectionCount: userManager.user?.collectionCount ?? 0)
        }
    }

    // MARK: - Private Properties

    private var headerView: some View {
        Text("Other")
            .font(.system(size: 24, weight: .semibold))
            .foregroundStyle(.primaryForeground)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.selectedPickerTab == .news {
            newsSection
        } else {
            achievementsSection
        }
    }

    private var newsSection: some View {
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
    }

    private var achievementsSection: some View {
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

    private var newsDetailView: some View {
        NewsView(new: viewModel.selectedNews)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    newsToolbar
                }
            }
    }

    private var newsToolbar: some View {
        HStack {
            Text("News")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.primaryForeground)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    backButton
                }
        }
    }

    private var backButton: some View {
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

#Preview {
    OtherView()
}
