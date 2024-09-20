//
//  NewsView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct NewsView: View {
    let new: NewsType

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(new.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24)
                    )
                Text(new.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primaryForeground)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(new.text)
                    .font(.system(size: 20, weight: .medium))
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NewsView(new: .rybolovles)
}
