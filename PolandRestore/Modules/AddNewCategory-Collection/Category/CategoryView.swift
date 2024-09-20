//
//  CategoryView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct CategoryView: View {
    @StateObject private var viewModel = AddCategoryViewModel()
    
    @State private var showAddCollectionPage: Bool = false
    @State private var showCollectionPage: Bool = false
    var category: CategoryEntity?
    @State private var collectionPrimary: CollectionEntity?
    
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
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
                            
                        Button(action: { viewModel.isDeletePopupPresent.toggle() }) {
                            Image("broom")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.primaryText)
                                .padding()
                                .background {
                                    Circle()
                                        .foregroundStyle(.primaryForeground)
                                }
                        }
                    }
                        
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
                
                Button(action: {
                    showAddCollectionPage.toggle()
                }) {
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
                
                Text("Your collections")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 40)
                    .foregroundStyle(.primaryForeground)

                ScrollView {
                    if let collections = category?.colections as? Set<CollectionEntity> {
                        let collectionsArray = Array(collections).sorted { $0.name ?? "" < $1.name ?? "" }
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(collectionsArray, id: \.self) { collection in
                                CollectionCardView(
                                    collections: collection,
                                    onTapCard: {
                                        collectionPrimary = collection
                                        showCollectionPage.toggle()
                                    }
                                )
                            }
                        }
                    } else {}
                }
                
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
}

//
// #Preview {
//    CollectionView(category: .init(entity: "1", insertInto: "test"))
// }
