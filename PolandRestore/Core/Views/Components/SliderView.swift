//
//  SliderView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct SliderView: View {
    // MARK: - Public Properties

    @Binding var progress: CGFloat

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            let verticalPadding = geometry.size.height / 21
            let progressWidth = geometry.size.width * progress
            let isComplete = progress == 1

            ZStack(alignment: .leading) {
                backgroundCapsule(verticalPadding: verticalPadding)
                foregroundCapsule(progressWidth: progressWidth, verticalPadding: verticalPadding, isComplete: isComplete)
            }
            .overlay(alignment: .leading) {
                progressText(isComplete: isComplete)
            }
        }
    }

    // MARK: - Private Methods

    private func backgroundCapsule(verticalPadding: CGFloat) -> some View {
        Capsule()
            .foregroundColor(.primaryForeground.opacity(0.25))
            .padding(.vertical, verticalPadding)
    }

    private func foregroundCapsule(progressWidth: CGFloat, verticalPadding: CGFloat, isComplete: Bool) -> some View {
        Capsule()
            .fill(isComplete ? Color.primaryText : .primaryForeground)
            .frame(width: progressWidth)
            .padding(.vertical, verticalPadding)
    }

    private func progressText(isComplete: Bool) -> some View {
        Text("\(Int(progress * 100))%")
            .font(.system(size: 10, weight: .semibold))
            .padding(.horizontal, 10)
            .foregroundStyle(isComplete ? Color.primaryForeground : .primaryText)
    }
}

#Preview {
    SliderView(progress: .constant(0.2))
        .frame(height: 21)
        .padding()
    SliderView(progress: .constant(1))
        .frame(height: 21)
        .padding()
}
