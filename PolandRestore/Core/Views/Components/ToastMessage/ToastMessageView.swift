//
//  ToastMessageView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct ToastMessageView: View {
    // MARK: - Public Properties

    let achievements: AchievementType

    // MARK: - Body

    var body: some View {
        VStack {
            Text(achievements.rawValue)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading])
                .minimumScaleFactor(0.45)
                .lineLimit(2)

            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    SliderView(progress: .constant(1))
                        .frame(width: 200, height: 21)

                    Text("Complate!")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(Color.primaryText)
                }

                Spacer()

                Image("complate")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 60)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.primaryForeground)

            VStack {
                Image("fire")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.9)
                Image("fire")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.8)
                Image("fire")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.7)
            }
            .padding(6)
        }
        .padding()
        .transition(
            .asymmetric(
                insertion: .push(from: .top),
                removal: .push(from: .bottom)
            )
            .combined(with: .opacity)
        )
    }
}

#Preview {
    ToastMessageView(achievements: .createThree)
    ToastMessageView(achievements: .createFirst)
}
