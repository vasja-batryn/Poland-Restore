//
//  AchievementsCard.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct AchievementsCard: View {
    let achievements: AchievementType

    // MARK: - Public Properties

    @Binding var progress: CGFloat
    var collectionCount: Int

    var body: some View {
        VStack {
            Text(achievements.rawValue)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(progress == 1 ? Color.primaryText : .primaryForeground)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading])

            SliderView(progress: .constant(progress))
                .frame(width: 200, height: 21)
                .padding([.bottom, .trailing])
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(progress == 1 ? Color.primaryForeground : .tertiaryForeground)

            VStack {
                Image("fire")
                    .resizable()
                    .scaledToFit()
                    .opacity(progress == 1 ? 0.9 : 0.5)
                Image("fire")
                    .resizable()
                    .scaledToFit()
                    .opacity(progress == 1 ? 0.8 : 0.4)
                Image("fire")
                    .resizable()
                    .scaledToFit()
                    .opacity(progress == 1 ? 0.7 : 0.2)
            }
            .padding(6)
        }
        .padding()
        .onAppear {
            updateProgress()
        }
    }

    private func updateProgress() {
        switch achievements {
        case .createFirst:
            progress = collectionCount >= 1 ? 1 : CGFloat(collectionCount) / 1
        case .createThree:
            progress = collectionCount >= 3 ? 1 : CGFloat(collectionCount) / 3
        case .createFive:
            progress = collectionCount >= 5 ? 1 : CGFloat(collectionCount) / 5
        case .createNine:
            progress = collectionCount >= 9 ? 1 : CGFloat(collectionCount) / 9
        }
    }
}

#Preview {
    AchievementsCard(achievements: .createFirst, progress: .constant(0.33), collectionCount: 1)

    AchievementsCard(achievements: .createFive, progress: .constant(1), collectionCount: 3)
}
