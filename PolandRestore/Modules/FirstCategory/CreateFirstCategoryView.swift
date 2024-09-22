//
//  CreateFirstCategoryView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct CreateFirstCategoryView: View {
    // MARK: - Private Properties

    @State private var showAddNewCategoryPage: Bool = false
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Let's create our first \ncategory?")
                    .font(.system(size: 32, weight: .semibold))
                
                Image.anyCategories
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                VStack(alignment: .center, spacing: 10) {
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
                    action: { showAddNewCategoryPage.toggle() }
                )
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showAddNewCategoryPage) {
                AddNewCategory(isFirstOpen: true)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    CreateFirstCategoryView()
}
