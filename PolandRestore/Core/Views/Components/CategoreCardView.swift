//
//  CategoreCardView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct CategoreCardView: View {
    // MARK: - Public Propertis

    var category: CategoryEntity
    let onTapCard: () -> Void

    // MARK: - Private Properties

    private let imageWidth: CGFloat = 170
    private let imageHeight: CGFloat = 220
    private let cornerRadius: CGFloat = 24

    // MARK: - Body

    var body: some View {
        Button(action: onTapCard) {
            VStack {
                categoryImageView
                    .shadow(color: .secondaryForeground.opacity(0.25), radius: 4, x: 0, y: 4)
                    .padding(.bottom, 5)
                
                if let name = category.name {
                    categoryText(name)
                }

                if let categoryType = category.categoryType {
                    categoryText(categoryType, isSecondary: true)
                }
            }
            .frame(width: imageWidth)
        }
    }

    // MARK: - Private Properties

    @ViewBuilder
    private var categoryImageView: some View {
        if let imageData = category.image, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageWidth, height: imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .clipped()

        } else {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.gray.opacity(0.3))
                .frame(width: imageWidth, height: imageHeight)
        }
    }

    private func categoryText(_ text: String, isSecondary: Bool = false) -> some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(isSecondary ? .secondaryForeground : .primaryForeground)
    }
}
