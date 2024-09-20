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
            ZStack(alignment: .leading) {
                let verticalPadding = geometry.size.height / 21

                Capsule()
                    .foregroundColor(.primaryForeground.opacity(0.25))
                    .padding(.vertical, verticalPadding)

                Capsule()
                    .fill(progress == 1 ? Color.primaryText : .primaryForeground)
                    .frame(width: geometry.size.width * progress)
                    .padding(.vertical, verticalPadding)
            }
            .overlay(alignment: .leading) {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 10, weight: .semibold))
                    .padding(.horizontal, 10)
                    .foregroundStyle(progress == 1 ? Color.primaryForeground : .primaryText)
            }
        }
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
