//
//  OnboardingView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Public Properties

    @StateObject private var viewModel = OnboardingViewModel()
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    ForEach(viewModel.pages) { page in
                        OnboardingPageView(
                            imageName: page.image
                        )
                        .offset(x: -geometry.size.width * CGFloat(viewModel.currentPageIndex - (viewModel.pages.firstIndex(of: page) ?? 0)))
                    }
                }
                .animation(.spring(), value: viewModel.currentPageIndex)
                
                VStack {
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
                    .padding(.bottom)
                    .foregroundStyle(Color.black)
                    
                    HStack(spacing: 60) {
                        PageIndicator(numberOfPages: viewModel.numberOfPages, currentPage: $viewModel.currentPageIndex)
                        
                        Button(action: { viewModel.didTapNextButton() }) {
                            Text("Next")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                        }
                        
                        .background {
                            Color.primaryForeground
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.showNamePage) {
                NamePage()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
