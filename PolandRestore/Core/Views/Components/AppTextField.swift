//
//  AppTextField.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct AppTextField: View {
    // MARK: - Public Properties

    @Binding var text: String
    let title: String
    let placeholder: String

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleView
                .padding(.leading, 5)

            TextField("", text: $text, axis: .horizontal)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder)
                        .foregroundStyle(Color.secondaryForeground.opacity(0.5))
                }
                .accentColor(.primaryForeground)
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primaryForeground, lineWidth: 2)
                )
                .font(.system(size: 18, weight: .semibold))
        }
        .padding()
    }

    // MARK: - Private Subviews

    private var titleView: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.secondaryForeground.opacity(0.25))
        }
    }
}

#Preview {
    AppTextField(text: .constant(""), title: "Your name", placeholder: "Name")
}
