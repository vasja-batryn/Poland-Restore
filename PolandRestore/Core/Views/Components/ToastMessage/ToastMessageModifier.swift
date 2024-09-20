//
//  ToastMessageModifier.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct ToastMessageModifier: ViewModifier {
    // MARK: - Public Properties

    let achievements: AchievementType
    @Binding var isPresented: Bool

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if isPresented {
                    ToastMessageView(achievements: achievements)
                        .task { await scheduleReset() }
                }
            }
            .animation(.easeInOut, value: isPresented)
    }

    // MARK: - Private Methods

    private func scheduleReset() async {
        try? await Task.sleep(for: .seconds(1.5))
        isPresented = false
    }
}

// MARK: - View+ToastMessageModifier

extension View {
    @ViewBuilder
    func toastMessage(_ achievements: AchievementType, isPresented: Binding<Bool>) -> some View {
        modifier(ToastMessageModifier(achievements: achievements, isPresented: isPresented))
    }
}
