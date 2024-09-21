//
//  OnboardingView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Private Properties

    @StateObject private var viewModel = OnboardingViewModel()

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                pageCarousel
                controlSection
            }
            .navigationDestination(isPresented: $viewModel.showNamePage) {
                NamePage()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }

    // MARK: - Private Properties

    private var pageCarousel: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.pages.indices, id: \.self) { index in
                    let page = viewModel.pages[index]
                    Image(page.image)
                        .resizable()
                        .scaledToFit()
                        .offset(x: -geometry.size.width * CGFloat(viewModel.currentPageIndex - index))
                        .opacity(viewModel.currentPageIndex == index ? 1 : 0)
                }
            }
            .animation(.spring(), value: viewModel.currentPageIndex)
        }
    }

    private var controlSection: some View {
        VStack {
            termsAndPrivacyLinks
                .padding(.bottom)

            HStack(spacing: 60) {
                PageIndicator(
                    numberOfPages: viewModel.numberOfPages,
                    currentPage: $viewModel.currentPageIndex
                )
                nextButton
            }
        }
    }

    private var termsAndPrivacyLinks: some View {
        HStack {
            Button(action: {}) {
                Text("Terms of use")
                    .font(.system(size: 12, weight: .medium))
            }

            Text("|")
                .font(.system(size: 12, weight: .medium))

            Button(action: {}) {
                Text("Privacy Policy")
                    .font(.system(size: 12, weight: .medium))
            }
        }
        .foregroundStyle(Color.black)
    }

    private var nextButton: some View {
        Button(action: {
            viewModel.didTapNextButton()
        }) {
            Text("Next")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(Color.primaryForeground)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    OnboardingView()
}
