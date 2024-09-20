//
//  SecondaryButton.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct SecondaryButton: View {
    // MARK: - Public Properties
    let type: CategoryType?
    var isSelect: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(type?.rawValue ?? "")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(isSelect ? .primaryForeground : .tertiaryForeground)
                            .font(.system(size: 14, weight: .medium))
                    }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .accentColor(.secondaryForeground)
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primaryForeground, lineWidth: 2)
            )
            .font(.system(size: 18, weight: .semibold))
        }
    }
}

#Preview {
    SecondaryButton(
        type: .old,
        isSelect: false,
        onTap: {}
    )
}
