//
//  AddCategoryViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 19.09.2024.
//

import CoreData
import PhotosUI
import SwiftUI

final class AddCategoryViewModel: ObservableObject {
    // MARK: - Public Propertis
    
    @Published var selectedImage: UIImage?
    @Published var selectedCategoryType: CategoryType? = nil
    @Published var categories: [CategoryEntity] = []
    @Published var selectedCategory: CategoryEntity?
    @Published var isPhotoLibraryPresented = false
    @Published var isDeletePopupPresent = false
    @Published var isFinishPresented = false
    @Published var categoryName: String = ""
    @Published var photosPickerItem: PhotosPickerItem? {
        didSet {
            isPhotoLibraryPresented = false
            fetchImage()
        }
    }
    
    // MARK: - Private Properties

    private let viewContext = PersistenceController.shared.container.viewContext
    
    // MARK: - Public Methods

    func saveCollection() {
        let newCategory = CategoryEntity(context: viewContext)
        newCategory.id = UUID()
        newCategory.name = categoryName
        newCategory.categoryType = selectedCategoryType?.rawValue ?? ""
        
        if let image = selectedImage, let imageData = image.pngData() {
            newCategory.image = imageData
        }
        
        PersistenceController.shared.save()
        updateUserCollectionCount()
    }
    
    func fetchCategories() -> [CategoryEntity] {
        let request: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching categories: \(error)")
            return []
        }
    }
    
    func deleteCategory() {
        if let categoryToDelete = selectedCategory {
            viewContext.delete(categoryToDelete)
            
            do {
                try viewContext.save()
                categories = fetchCategories()
            } catch {
                print("Error deleting category: \(error)")
            }
        } else {
            print("No category selected to delete.")
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchImage() {
        Task {
            if let data = try? await photosPickerItem?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    self.selectedImage = uiImage
                }
            }
        }
    }

    private func updateUserCollectionCount() {
        if var user = UserManager.shared.loadUser() {
            user.collectionCount += 1
            UserManager.shared.saveUser(user)
                
            OtherViewModel.shared.updateAchievementProgress(collectionCount: user.collectionCount)
        }
    }
}
