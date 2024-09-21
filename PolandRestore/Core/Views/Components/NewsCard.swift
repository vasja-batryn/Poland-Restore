//
//  NewsCard.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct NewsCard: View {
    // MARK: - Public Propertis

    let card: NewsType
    let onTapCard: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: onTapCard) {
            VStack {
                Image(card.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .gray.opacity(0.6), radius: 4, x: 0, y: 4)
                    .overlay(contentOverlay)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var contentOverlay: some View {
        HStack {
            Text(card.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.primaryText)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .shadow(color: .gray.opacity(0.6), radius: 4, x: 0, y: 4)

            chevronButton
        }
    }

    private var chevronButton: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 25, weight: .medium))
            .foregroundStyle(.white)
            .padding()
            .background(Circle().fill(Color.primaryForeground))
            .padding()
    }
}

#Preview {
    NewsCard(card: .rybolovles, onTapCard: {})
}
