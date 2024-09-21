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
    
    // MARK: - Private Properties
    private let types = CategoryType.allCases
    @State private var isDrop: Bool = false

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Category type")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.secondaryForeground.opacity(0.25))
                .padding(.leading, 5)

            HStack {
                Text(selectedCategoryType?.rawValue ?? "")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 20)
                    .padding(.vertical, 4)
                    .overlay(alignment: .trailing) {
                        Button(action: { isDrop.toggle() }) {
                            Image(systemName: isDrop ? "chevron.up" : "chevron.down"
                            )
                            .font(.system(size: 25, weight: .medium))
                        }
                    }
            }
            .padding(.vertical, 13)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primaryForeground, lineWidth: 2)
            )
            .accentColor(.primaryForeground)

            if isDrop {
                VStack(spacing: 15) {
                    ForEach(types, id: \.self) { type in
                        SecondaryButton(
                            type: type,
                            isSelect: selectedCategoryType == type,
                            onTap: { selectedCategoryType = type }
                        )
                    }
                }
                .transition(.opacity)
                .padding(.vertical, 10)
            }
        }
        .animation(.spring(duration: 0.6), value: isDrop)
        .padding()
    }
}

#Preview {
    CategoryDropdown(selectedCategoryType: .constant(.none))
    
    CategoryDropdown(selectedCategoryType: .constant(.old))
}


