//
//  NewsCard.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct NewsCard: View {
    let card: NewsType
    let onTapCard: () -> Void
    
    var body: some View {
        VStack {
            Image(card.image)
                .resizable()
                .scaledToFit()
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )
                .shadow(color: .gray, radius: 4, x: 0, y: 4)
                .overlay(
                    HStack {
                        Text(card.title)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.primaryText)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding()
                        
                        Button(action: onTapCard) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 25, weight: .medium))
                                .foregroundStyle(.primaryText)
                                .padding()
                                .background {
                                    Circle()
                                        .foregroundStyle(.primaryForeground)
                                }
                        }
                        
                        .padding()
                    }
                )
        }
        .padding()
    }
}

#Preview {
    NewsCard(card: .rybolovles, onTapCard: {})
}
