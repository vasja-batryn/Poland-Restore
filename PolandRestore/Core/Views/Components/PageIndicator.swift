//
//  PageIndicator.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct PageIndicator: View {
    // MARK: - Public Properties

    let numberOfPages: Int
    @Binding var currentPage: Int

    // MARK: - Private Properties

    private let dotDiameter: CGFloat = 12
    private var activeIndicatorWidth: CGFloat {
        dotDiameter * 4 - dotDiameter / 2
    }

    private var indicatorOffset: CGFloat {
        CGFloat(currentPage) * dotDiameter * 2
    }

    // MARK: - Body

    var body: some View {
        HStack(spacing: dotDiameter) {
            ForEach(0 ..< numberOfPages, id: \.self) { page in
                Capsule()
                    .fill(
                        currentPage == page ? Color.primaryForeground : Color.secondaryForeground.opacity(0.5)
                    )
                    .frame(
                        width: activeIndicatorWidth,
                        height: dotDiameter
                    )
                    .shadow(color: currentPage == page ? .gray : .white, radius: 3, x: 0, y: 3)
            }
        }

        .animation(.easeInOut, value: currentPage)
    }
}

#Preview {
    PageIndicator(
        numberOfPages: 3,
        currentPage: .constant(2)
    )
    .preferredColorScheme(.light)
}
