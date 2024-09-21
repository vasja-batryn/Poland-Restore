//
//  CategoryView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct CategoryView: View {
    // MARK: - Public Propertis

    @Environment(\.dismiss) var dismiss
    var category: CategoryEntity?
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    // MARK: - Private Properties

    @StateObject private var viewModel = AddCategoryViewModel()
    @State private var showAddCollectionPage = false
    @State private var showCollectionPage = false
    @State private var collectionPrimary: CollectionEntity?
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerView
                addButton
                collectionTitle
                collectionGrid
                Spacer()
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showAddCollectionPage) {
                AddNewCollection(selectedCollectionCategory: category)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $showCollectionPage) {
                CollectionView(collection: collectionPrimary)
                    .navigationBarBackButtonHidden(true)
            }
            .deleteMessage(
                isPresented: $viewModel.isDeletePopupPresent,
                onTapYes: {
                    viewModel.selectedCategory = category
                    viewModel.deleteCategory()
                    dismiss()
                }
            )
        }
    }
    
    // MARK: - Private Properties
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack {
                VStack(alignment: .leading, spacing: 13) {
                    Text("\(category?.name ?? "")/")
                        .foregroundColor(.secondaryForeground)
                        .font(.system(size: 24, weight: .semibold))
                        + Text("\(category?.categoryType?.lowercased() ?? "")")
                        .foregroundColor(.primaryForeground)
                        .font(.system(size: 24, weight: .semibold))
                    Text("Add new category")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.secondaryForeground.opacity(0.5))
                }
                Spacer()
                deleteButton
            }
            backButton
        }
    }
    
    private var deleteButton: some View {
        Button(action: { viewModel.isDeletePopupPresent.toggle() }) {
            Image("broom")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundStyle(.primaryText)
                .padding(8)
                .background(Circle().foregroundStyle(.primaryForeground))
        }
    }
    
    private var backButton: some View {
        Button(action: { dismiss() }) {
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
    
    private var addButton: some View {
        Button(action: { showAddCollectionPage.toggle() }) {
            Image(systemName: "plus")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(.primaryText)
                .padding()
                .background(Circle().foregroundStyle(.primaryForeground))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }
    
    private var collectionTitle: some View {
        Text("Your collections")
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(.primaryForeground)
            .padding(.top, 40)
    }
    
    private var collectionGrid: some View {
        ScrollView {
            if let collections = category?.colections as? Set<CollectionEntity> {
                let collectionsArray = collections.sorted { ($0.name ?? "") < ($1.name ?? "") }
                LazyVGrid(columns: columns) {
                    ForEach(collectionsArray, id: \.self) { collection in
                        CollectionCardView(collection: collection) {
                            collectionPrimary = collection
                            showCollectionPage.toggle()
                        }
                    }
                }
            }
        }
        .padding()
    }
}
