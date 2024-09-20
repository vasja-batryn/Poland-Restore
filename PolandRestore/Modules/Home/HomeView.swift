//
//  HomeView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = AddCategoryViewModel()
      
    @State private var showAddCategoryPage: Bool = false
    @State private var showCollectionPage: Bool = false
    @State private var selectedCategory: CategoryEntity?
    @State private var showEmptyCategoryView: Bool = false

    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 13) {
                    Text("Menu")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.primaryForeground)
                    
                    Text("Add new category")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondaryForeground.opacity(0.5))
                }
                
                Button(action: { showAddCategoryPage.toggle() }) {
                    Image(systemName: "plus")
                        .font(.system(size: 40, weight: .light))
                        .foregroundStyle(.primaryText)
                        .padding()
                        .background {
                            Circle()
                                .foregroundStyle(.primaryForeground)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                
                Text("Your category")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 40)
                
                ScrollView {
                    if viewModel.categories.isEmpty {
                        Text("No categories created yet.")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else {
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
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showAddCategoryPage) {
                AddNewCategory(isfirstOpen: false)
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
}

#Preview {
    HomeView()
}
