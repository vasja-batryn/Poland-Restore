//
//  HomeView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Public Propertis
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    // MARK: - Private Properties

    @StateObject private var viewModel = AddCategoryViewModel()

    @State private var showAddCategoryPage = false
    @State private var showCollectionPage = false
    @State private var selectedCategory: CategoryEntity?
    @State private var showEmptyCategoryView = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerView
                addCategoryButton
                categorySection
                Spacer()
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showAddCategoryPage) {
                AddNewCategory(isFirstOpen: false)
                    .environmentObject(viewModel)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $showCollectionPage) {
                CategoryView(category: selectedCategory)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $showEmptyCategoryView) {
                EmptyCategoryView(category: selectedCategory)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            viewModel.categories = viewModel.fetchCategories()
        }
    }

    // MARK: - Private Properties

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text("Menu")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.primaryForeground)

            Text("Add new category")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.secondaryForeground.opacity(0.5))
        }
    }

    private var addCategoryButton: some View {
        Button(action: { showAddCategoryPage.toggle() }) {
            Image(systemName: "plus")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(.primaryText)
                .padding()
                .background(Circle().foregroundStyle(.primaryForeground))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }

    private var categorySection: some View {
        VStack(alignment: .leading) {
            Text("Your category")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 40)
                .padding(.bottom)

            ScrollView {
                if viewModel.categories.isEmpty {
                    emptyCategoryMessage
                } else {
                    categoryGrid
                }
            }
        }
    }

    private var emptyCategoryMessage: some View {
        Text("No categories created yet.")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .center)
    }

    private var categoryGrid: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.categories, id: \.self) { category in
                CategoreCardView(category: category) {
                    selectedCategory = category
                    if let collections = category.colections as? Set<CollectionEntity>, collections.isEmpty {
                        showEmptyCategoryView = true
                    } else {
                        showCollectionPage = true
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
