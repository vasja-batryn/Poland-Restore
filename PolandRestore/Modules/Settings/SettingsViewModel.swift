//
//  SettingsViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 18.09.2024.
//

import CoreData
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

    @Environment(\.openURL) var openURL

    // MARK: - Private Properties

    private let userKey = "userAvatar"
    private let context = PersistenceController.shared.context

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

    func termOfUse() {
        openURL(URL(string: "https://www.termsfeed.com/live/afcf5553-3121-4d8f-a3b5-a97af53d9db0")!)
    }

    func privacyPolicy() {
        openURL(URL(string: "https://www.termsfeed.com/live/afcf5553-3121-4d8f-a3b5-a97af53d9db0")!)
    }

    func support() {
        openURL(URL(string: "https://landing.flycricket.io/poland-restore/fae82d9b-cf94-4956-afa8-014ea382602c/?t=1727087039&_gl=1*m0jmaq*_ga*MTQ5MTc2MTM5Mi4xNzI3MDg1NTg5*_ga_P77BJ8Z1XM*MTcyNzA4NTU4OS4xLjEuMTcyNzA4Njk0NS4wLjAuMA")!)
    }

    func resetAllData() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = CollectionEntity.fetchRequest()
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = CategoryEntity.fetchRequest()

        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)

        do {
            try context.execute(batchDeleteRequest1)
            try context.execute(batchDeleteRequest2)
            try context.save()
            print("All collections and categories deleted successfully.")
        } catch {
            print("Failed to delete data: \(error)")
        }
    }

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
