//
//  OtherViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import Foundation

final class OtherViewModel: ObservableObject {
    // MARK: - Public Propertis

    static let shared = OtherViewModel()

    @Published var progressValues: [AchievementType: CGFloat] = [:]
    @Published var selectedPickerTab: OtherType = .news
    @Published var selectedNews: NewsType = .rybolovles
    @Published var presentNews: Bool = false
    @Published var completedAchievement: AchievementType? = nil

    let otherTypes = OtherType.allCases
    let cards = NewsType.allCases
    let achievements = AchievementType.allCases

    // MARK: - Private Properties

    private var shownAchievements: Set<AchievementType> = []

    // MARK: - Public Methods

    func updateAchievementProgress(collectionCount: Int) {
        for achievement in achievements {
            var progress: CGFloat = 0
            switch achievement {
            case .createFirst:
                progress = collectionCount >= 1 ? 1 : CGFloat(collectionCount) / 1
            case .createThree:
                progress = collectionCount >= 3 ? 1 : CGFloat(collectionCount) / 3
            case .createFive:
                progress = collectionCount >= 5 ? 1 : CGFloat(collectionCount) / 5
            case .createNine:
                progress = collectionCount >= 9 ? 1 : CGFloat(collectionCount) / 9
            }

            progressValues[achievement] = progress

            if progress == 1, !shownAchievements.contains(achievement) {
                completedAchievement = achievement
                shownAchievements.insert(achievement)
            }
        }
    }

    func resetCompletedAchievement() {
        completedAchievement = nil
    }
}
