//
//  NamePage.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct NamePage: View {
    // MARK: - Public Properties

    @StateObject private var viewModel = NamePageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Let's get acquainted!")
                    .font(.system(size: 32, weight: .semibold))
                
                Text("What's your name?")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.primaryForeground)
                
                Spacer()
                
                AppTextField(
                    text: $viewModel.name,
                    title: "Your name",
                    placeholder: "Name"
                )
                
                Spacer()
                
                PrimaryButton(
                    title: "Next step",
                    action: {
                        viewModel.saveUser()
                        viewModel.showHelloPage.toggle()
                    }
                )
                .disabled(viewModel.name == "")
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $viewModel.showHelloPage) {
                HelloView(name: viewModel.name)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    NamePage()
}
