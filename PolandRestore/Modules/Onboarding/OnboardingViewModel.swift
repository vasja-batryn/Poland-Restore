//
//  OnboardingViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import Foundation
import UIKit

@MainActor
final class OnboardingViewModel: ObservableObject {
    // MARK: - Public Properties

    let pages = OnboardingPage.allCases
    @Published var showNamePage = false

    var numberOfPages: Int {
        pages.count
    }

    var isFirstPage: Bool {
        currentPageIndex == 0
    }

    var isLastPage: Bool {
        currentPageIndex == numberOfPages - 1
    }

    @Published var currentPageIndex = 0

    func didTapNextButton() {
        guard currentPageIndex + 1 < numberOfPages else {
            showNamePage.toggle()
            return
        }

        currentPageIndex += 1
    }
}
