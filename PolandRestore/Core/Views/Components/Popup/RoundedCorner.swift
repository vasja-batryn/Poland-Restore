//
//  RoundedCorner.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

private struct RoundedCorner: Shape {
    // MARK: - Public Properties

    let radius: CGFloat
    let corners: UIRectCorner

    // MARK: - Path

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        return Path(path.cgPath)
    }
}

// MARK: - View+RoundedCorner

extension View {
    func roundedCorner(
        _ radius: CGFloat,
        corners: UIRectCorner = .allCorners
    ) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
