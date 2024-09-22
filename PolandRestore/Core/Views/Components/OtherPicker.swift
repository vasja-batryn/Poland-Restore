//
//  OtherPicker.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 17.09.2024.
//

import SwiftUI

struct OtherPicker: View {
    // MARK: - Public Properties

    @Binding var selectedTab: OtherType
    let types: [OtherType]

    // MARK: - Body

    var body: some View {
        HStack(spacing: 27) {
            ForEach(types) { tab in
                Text(tab.rawValue)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(selectedTab == tab ? Color.primaryText : .primaryForeground)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selectedTab == tab ? Color.primaryForeground : .tertiaryForeground.opacity(0.5))
                    }
                    .onTapGesture {
                        selectedTab = tab
                    }
            }
        }
    }
}

#Preview {
    OtherPicker(
        selectedTab: .constant(.news),
        types: OtherType.allCases
    )
}
