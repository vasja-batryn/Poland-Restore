//
//  OnboardingPageView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    // MARK: - Public Properties

    let imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    OnboardingPageView(imageName: "Onboarding-1")
}
