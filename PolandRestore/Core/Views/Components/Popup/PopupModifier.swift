//
//  PopupModifier.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct PopupModifier<PopupContent: View>: ViewModifier {
    // MARK: - Public Properties

    @Binding var isPresented: Bool
    var isCloseBackground: Bool = true
    let popupContent: () -> PopupContent

    // MARK: - Body

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.secondaryForeground.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        if isCloseBackground {
                            isPresented = false
                        }
                    }

                popupContent()
                    .zIndex(1)
                    .transition(
                        .move(edge: .bottom)
                            .combined(with: .opacity)
                    )
            }
        }
        .animation(.easeOut, value: isPresented)
    }
}

// MARK: - View+PopupModifier

extension View {
    func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        isCloseBackground: Bool,
        content: @escaping () -> PopupContent
    ) -> some View {
        modifier(
            PopupModifier(
                isPresented: isPresented,
                isCloseBackground: isCloseBackground,
                popupContent: content
            )
        )
    }
}
