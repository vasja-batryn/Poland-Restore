//
//  OnboardingViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import UIKit

@MainActor
final class OnboardingViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var showNamePage = false
    @Published var currentPageIndex = 0
    let pages = OnboardingPage.allCases

    var numberOfPages: Int {
        pages.count
    }

    var isFirstPage: Bool {
        currentPageIndex == 0
    }

    var isLastPage: Bool {
        currentPageIndex == numberOfPages - 1
    }

    // MARK: - Public Methods

    func didTapNextButton() {
        guard currentPageIndex + 1 < numberOfPages else {
            showNamePage.toggle()
            return
        }

        currentPageIndex += 1
    }
}
