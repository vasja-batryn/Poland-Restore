//
//  PrimaryButton.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct PrimaryButton: View {
    
    // MARK: - Public Properties
    let title: String
    var height: CGFloat = 50
    let action: () -> Void

    // MARK: - Body
    var body: some View {
        Button(title, action: action)
            .buttonStyle(PrimaryButtonStyle(height: height))
            .padding()
    }
}

#Preview {
    Group {
        PrimaryButton(
            title: "Next",
            action: {}
        )
        

        PrimaryButton(
            title: "Next",
            action: {}
        )
        .disabled(true)
    }
    .padding()
}
