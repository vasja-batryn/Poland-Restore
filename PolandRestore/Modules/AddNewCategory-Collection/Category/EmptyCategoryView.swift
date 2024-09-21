//
//  EmptyCategoryView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 19.09.2024.
//

import SwiftUI

struct EmptyCategoryView: View {
    // MARK: - Public Propertis

    var category: CategoryEntity?

    // MARK: - Private Properties

    @StateObject private var viewModel = AddCategoryViewModel()
    @State private var showAddNewCollectionPage: Bool = false
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("\(category?.name ?? "")/")
                    .foregroundColor(.secondaryForeground)
                    .font(.system(size: 24, weight: .semibold))
                    + Text("\(category?.categoryType ?? "")")
                    .foregroundColor(.primaryForeground)
                    .font(.system(size: 24, weight: .semibold))
                   
                Text("Add new collections")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.secondaryForeground.opacity(0.5))
                    .padding(.top, 1)
                
                Image("emptyCategory")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("Empty")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.primaryForeground.opacity(0.5))
                    Text("Let's get to creating!")
                        .font(.system(size: 18, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                PrimaryButton(
                    title: "Create",
                    action: { showAddNewCollectionPage.toggle() }
                )
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showAddNewCollectionPage) {
                AddNewCollection(selectedCollectionCategory: category)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    EmptyCategoryView()
}
