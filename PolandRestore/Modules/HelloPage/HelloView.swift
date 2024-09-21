//
//  HelloView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct HelloView: View {
    // MARK: - Public Propertis

    var name: String
    
    // MARK: - Private Properties

    @State private var showCreateFirstCategoryPage: Bool = false
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("That's great!")
                    .font(.system(size: 32, weight: .semibold))
                
                Spacer()
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Nice to meet you!")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(.primaryForeground)
                    Text(name)
                        .font(.system(size: 38, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                PrimaryButton(
                    title: "Next step",
                    action: { showCreateFirstCategoryPage.toggle() }
                )
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showCreateFirstCategoryPage) {
                CreateFirstCategoryView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    HelloView(name: "Andrey")
}
