//
//  DeleteMessagePopup.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

private struct DeleteMessagePopup: ViewModifier {
    // MARK: - Public Properties

    @Binding var isPresented: Bool
    let onTapYes: () -> Void

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .popup(
                isPresented: $isPresented,
                isCloseBackground: false
            ) {
                DeleteMessageView(
                    isPresented: $isPresented,
                    onTapYes: onTapYes
                )
            }
    }
}

// MARK: - View+ShareSheat

extension View {
    func deleteMessage(
        isPresented: Binding<Bool>,
        onTapYes: @escaping () -> Void
    ) -> some View {
        modifier(
            DeleteMessagePopup(
                isPresented: isPresented,
                onTapYes: onTapYes
            )
        )
    }
}
