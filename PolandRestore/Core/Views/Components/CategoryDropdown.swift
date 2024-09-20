//
//  CategoryDropdown.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct CategoryDropdown: View {
    // MARK: - Public Properties

    @Binding var selectedCategoryType: CategoryType?
    private let types = CategoryType.allCases
    @State var isDrop: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Text("Category type")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Color.secondaryForeground.opacity(0.25))
            }
            .padding(.leading, 5)

            HStack {
                Text(selectedCategoryType?.rawValue ?? "")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay(alignment: .trailing) {
                        Button(action: { isDrop.toggle() }) {
                            Image(systemName: isDrop ? "chevron.up" : "chevron.down")
                        }
                        
                    }
                    .padding(.vertical, 4)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .accentColor(.primaryForeground)
            .padding(.vertical, 13)
            .padding(.horizontal, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primaryForeground, lineWidth: 2)
            )
            .font(.system(size: 18, weight: .semibold))

            if isDrop {
                ForEach(types) { type in
                    SecondaryButton(
                        type: type,
                        isSelect: selectedCategoryType == type,
                        onTap: { selectedCategoryType = type }
                    )
                }
            }
        }
        .animation(.spring(duration: 0.6), value: isDrop)
        .padding()
    }
}

#Preview {
    CategoryDropdown(selectedCategoryType: .constant(.none))
}
