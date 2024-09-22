//
//  NamePage.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct NamePage: View {
    // MARK: - Private Properties

    @StateObject private var viewModel = NamePageViewModel()

    // MARK: - Body

    var body: some View {
        NavigationStack {
            content
                .padding(.horizontal)
                .navigationDestination(isPresented: $viewModel.showHelloPage) {
                    HelloView(name: viewModel.name)
                        .navigationBarBackButtonHidden(true)
                }
        }
    }

    // MARK: - Private Views

    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading) {
            headerText
            Spacer()
            inputSection
            Spacer()
            nextButton
        }
    }

    private var headerText: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Let's get acquainted!")
                .font(.system(size: 32, weight: .semibold))

            Text("What's your name?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.primaryForeground)
        }
    }

    private var inputSection: some View {
        AppTextField(
            text: $viewModel.name,
            title: "Your name",
            placeholder: "Name"
        )
    }

    private var nextButton: some View {
        PrimaryButton(
            title: "Next step",
            action: {
                viewModel.saveUser()
                viewModel.showHelloPage.toggle()
            }
        )
        .disabled(viewModel.name.isEmpty)
    }
}

#Preview {
    NamePage()
}
