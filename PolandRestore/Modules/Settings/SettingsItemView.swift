//
//  SettingsItemView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct SettingsItemView: View {
    // MARK: - Public Properties

    let item: SettingsItem
    @StateObject var viewModel = SettingsViewModel()

    // MARK: - Body

    var body: some View {
        Button(action: {
            viewModel.onSelectItem(item)
        }) {
            HStack {
                Image(item.image)
                    .padding(1)
                    .foregroundStyle(Color.primaryForeground)

                Spacer()

                Text(item.description)
                    .lineLimit(1)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondaryForeground)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.tertiaryText)
            }
            .padding(1)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsItemView(item: .termOfUse)
}
