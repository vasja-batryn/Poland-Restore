//
//  OnboardingPageView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 23.09.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    
    // MARK: - Public Properties
    let imageName: String
    let title: String
    let description: String
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .overlay(alignment: .bottom) {
                    VStack(spacing: 16) {
                        Text(title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.secondaryForeground)
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)
                        
                        Text(description)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.secondaryForeground)
                            .lineLimit(3)
                            .padding(.horizontal)
                            .minimumScaleFactor(0.4)
                    }
                    .padding(75)
                    .background {
                        Circle()
                            .stroke( Color.primaryForeground, style: .init(lineWidth: 3, dash: [10, 10]))
                            .foregroundStyle(.clear)
                
                    }
                    .offset(y: 50)
                }
        }
        .multilineTextAlignment(.center)
    }
}


#Preview {
    OnboardingPageView(imageName: "Onboarding-1", title: "Collections right in \nyour phone!", description: "Create your first personal \ncollection, from a wide \nvariety of items")
}
