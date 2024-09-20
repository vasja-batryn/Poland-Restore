//
//  CategoreCardView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct CategoreCardView: View {
    var category: CategoryEntity
    let onTapCard: () -> Void

    var body: some View {
        Button(action: onTapCard) {
            VStack {
                if let imageData = category.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 180, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(color: .secondaryForeground.opacity(0.25), radius: 4, x: 0, y: 4)
                }

                Text(category.name ?? "")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primaryForeground)
                    .padding(.top, 8)

                Text(category.categoryType ?? "")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.secondaryForeground)
            }
            .frame(width: 150)
            .padding()
        }
    }
}
