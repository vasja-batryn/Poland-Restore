//
//  PrimaryButtonStyle.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    // MARK: - Public Properties

    @Environment(\.isEnabled) var isEnabled
    let height: CGFloat

    // MARK: - Body

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.primaryText)
            .font(.system(size: 18, weight: .semibold))
            .frame(maxWidth: .infinity)
            .padding()
            .background(.primaryForeground.opacity(isEnabled ? 1 : 0.3))
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(
                        isEnabled ? .clear : .secondaryForeground.opacity(0.65)
                    )
            }
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .frame(height: height)
    }
}
