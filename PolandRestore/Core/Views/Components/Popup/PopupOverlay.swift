//
//  PopupOverlay.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct PopupOverlay: ViewModifier {
    // MARK: - Public Properties

    @Binding var isPresented: Bool
    let title: String
    let relativeHeight: CGFloat
    
    // MARK: - Private Properties

    private let cornerRadius: CGFloat = 8
    private let spacing: CGFloat = 18
    private let padding: CGFloat = 16
    
    // MARK: - Body

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            VStack(spacing: spacing) {
                titleView
                
                content
                    .padding(.horizontal, padding)
            }
            .padding(.top, padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.primaryForeground)
            .frame(
                height: geometry.size.height * relativeHeight +
                    geometry.safeAreaInsets.bottom
            )
            .roundedCorner(cornerRadius, corners: [.topLeft, .topRight])
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    // MARK: - View Properties

    private var closeButton: some View {
        Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 24))
                .fontWeight(.medium)
                .foregroundStyle(.primaryText)
        }
    }
    
    private var titleView: some View {
        HStack {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .lineLimit(1)
               
            Spacer()
            
            closeButton
        }
        .padding(.horizontal, padding)
    }
}

// MARK: - View+PopupOverlay

extension View {
    func popupOverlay(
        isPresented: Binding<Bool>,
        title: String,
        relativeHeight: CGFloat
    ) -> some View {
        modifier(
            PopupOverlay(
                isPresented: isPresented,
                title: title,
                relativeHeight: relativeHeight
            )
        )
    }
}
