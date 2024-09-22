//
//  SettingsItemsListView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct SettingsListView: View {
    // MARK: - Public Properties

    @StateObject var viewModel = SettingsViewModel()

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("Support & About")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.primaryForeground)
                .padding(.horizontal)

            VStack {
                ForEach(viewModel.settingsItems) { item in
                    SettingsItemView(item: item)
                    if item != .support {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
            }
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(.tertiaryForeground)
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("&Other")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primaryForeground)
                    .padding(.horizontal)

                Button(action: {}) {
                    Text("Resrt data")
                        .foregroundStyle(.secondaryForeground)
                        .padding()
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background {
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundStyle(.tertiaryForeground)
                        }
                        .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    SettingsListView(viewModel: SettingsViewModel())
        .preferredColorScheme(.dark)
}
