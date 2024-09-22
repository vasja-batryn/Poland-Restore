//
//  SettingsViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import PhotosUI
import SwiftUI

final class SettingsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var photosPickerItem: PhotosPickerItem? {
        didSet {
            isPhotoLibraryPresented = false
            fetchImage()
        }
    }

    @Published var selectedImage: UIImage?
    @Published var isPhotoLibraryPresented = false
    @Published var isEditMode = false

    let settingsItems: [SettingsItem] = SettingsItem.allCases

    // MARK: - Private Properties

    private let userKey = "userAvatar"

    // MARK: - Public Methods

    func onSelectItem(_ item: SettingsItem) {
        switch item {
        case .termOfUse:
            termOfUse()
        case .privacyPolicy:
            privacyPolicy()
        case .support:
            support()
        }
    }

    func termOfUse() {}

    func privacyPolicy() {}

    func support() {}

    func loadAvatarFromUserDefaults() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: userKey),
           let image = UIImage(data: imageData)
        {
            return image
        }
        return nil
    }

    // MARK: - Private Methods

    private func fetchImage() {
        Task {
            if let data = try? await photosPickerItem?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    self.selectedImage = uiImage
                    self.saveAvatarToUserDefaults(image: uiImage)
                }
            }
        }
    }

    private func saveAvatarToUserDefaults(image: UIImage) {
        if let imageData = image.pngData() {
            UserDefaults.standard.set(imageData, forKey: userKey)
        }
    }
}
