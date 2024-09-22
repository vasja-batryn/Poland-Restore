//
//  CollectionCardView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 19.09.2024.
//

import SwiftUI

struct CollectionCardView: View {
    // MARK: - Public Propertis

    var collection: CollectionEntity
    let onTapCard: () -> Void

    // MARK: - Private Properties

    private let imageWidth: CGFloat = 170
    private let imageHeight: CGFloat = 220
    private let cornerRadius: CGFloat = 24

    // MARK: - Body

    var body: some View {
        Button(action: onTapCard) {
            VStack {
                collectionImageView
                    .shadow(color: .secondaryForeground.opacity(0.25), radius: 4, x: 0, y: 4)
                    .padding(.bottom, 5)
                
                if let name = collection.name {
                    collectionText(name)
                }

                if let categoryType = collection.categoryType {
                    collectionText(categoryType, isSecondary: true)
                }
            }
            .frame(width: imageWidth)
        }
    }

    // MARK: - Private Properties

    @ViewBuilder
    private var collectionImageView: some View {
        if let imageData = collection.image, let uiImage = UIImage(data: imageData) {
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

    private func collectionText(_ text: String, isSecondary: Bool = false) -> some View {
        Text(text)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(isSecondary ? .secondaryForeground : .primaryForeground)
    }
}
