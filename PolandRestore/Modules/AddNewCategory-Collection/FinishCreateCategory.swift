//
//  FinishCreateCategory.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct FinishCreateCategory: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Good!")
                .font(.system(size: 32, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            Image.fingerUp
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 256, maxHeight: 256)
                .padding(.vertical, 47)

            VStack(spacing: 15) {
                Text("You created the first category!")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.primaryForeground)

                Text("Now you can start using \nthe application")
                    .font(.system(size: 18, weight: .semibold))
                    .multilineTextAlignment(.center)
            }

            Spacer()

            PrimaryButton(
                title: "Next",
                action: {
                    UserDefaults.standard.set(
                        value: false,
                        forKey: .showOnboarding
                    )
                    dismiss()
                }
            )
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

#Preview {
    FinishCreateCategory()
}
