//
//  AchievementsCard.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import SwiftUI

struct AchievementsCard: View {
    // MARK: - Public Properties

    let achievements: AchievementType
    @Binding var progress: CGFloat
    var collectionCount: Int

    // MARK: - Private Properties

    private let imageNames = ["Fire", "Fire", "Fire"]

    // MARK: - Body

    var body: some View {
        VStack {
            header
            SliderView(progress: $progress)
                .frame(width: 200, height: 21)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.bottom, .trailing])
        }
        .background(backgroundView)
        .cornerRadius(12)
        .padding(.vertical)
        .onAppear(perform: updateProgress)
    }

    // MARK: - Private Properties

    private var header: some View {
        Text(achievements.rawValue)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(progress == 1 ? Color.primaryText : .primaryForeground)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top, .leading])
    }

    private var backgroundView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(progress == 1 ? Color.primaryForeground : .tertiaryForeground.opacity(0.5))

            VStack(spacing: 5) {
                ForEach(imageNames.indices, id: \.self) { index in
                    Image(imageNames[index])
                        .resizable()
                        .scaledToFill()
                        .opacity(fireOpacity(for: index))
                        
                }
            }
            .padding(6)
        }
    }

    // MARK: - Private Methods

    private func fireOpacity(for index: Int) -> Double {
        let baseOpacity = [1, 0.8, 0.7]
        return progress == 1 ? baseOpacity[index] : baseOpacity[index] - 0.6
    }

    private func updateProgress() {
        let achievementTarget: CGFloat
        switch achievements {
        case .createFirst:
            achievementTarget = 1
        case .createThree:
            achievementTarget = 3
        case .createFive:
            achievementTarget = 5
        case .createNine:
            achievementTarget = 9
        }
        progress = collectionCount >= Int(achievementTarget) ? 1 : CGFloat(collectionCount) / achievementTarget
    }
}

#Preview {
    AchievementsCard(achievements: .createFirst, progress: .constant(0.33), collectionCount: 1)

    AchievementsCard(achievements: .createFirst, progress: .constant(1), collectionCount: 1)

    AchievementsCard(achievements: .createFive, progress: .constant(1), collectionCount: 3)
}
