//
//  AddNewCollectionViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import CoreData
import PhotosUI
import SwiftUI

final class AddNewCollectionViewModel: ObservableObject {
    // MARK: - Public Propertis

    @Published var selectedCollectionCategory: CategoryEntity?
    @Published var selectedCollectionType: CategoryType? = nil
    @Published var selectedCollectionImage: UIImage?
    @Published var isPhotoLibraryPresented = false
    @Published var isDeletePopupPresent = false
    @Published var collectionName: String = ""
    @Published var collectionCost: String = ""
    @Published var collectionDate: String = ""
    @Published var selectedCollection: CollectionEntity?
    @Published var photosPickerItem: PhotosPickerItem? {
        didSet {
            isPhotoLibraryPresented = false
            fetchImage()
        }
    }

    // MARK: - Private Properties

    private let viewContext = PersistenceController.shared.container.viewContext
    
    // MARK: - Public Methods

    func addCollection() {
        guard selectedCollectionCategory != nil else {
            print("Category not selected")
            return
        }
        
        let newCollection = CollectionEntity(context: viewContext)
        newCollection.id = UUID()
        newCollection.name = collectionName
        newCollection.cost = collectionCost
        newCollection.year = collectionDate
        newCollection.categoryType = selectedCollectionType?.rawValue ?? ""
        if let image = selectedCollectionImage, let imageData = image.pngData() {
            newCollection.image = imageData
        }
        
        selectedCollectionCategory?.addToColections(newCollection)
        
        do {
            try viewContext.save()
            print("Collection added successfully")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func deleteCollection() {
        if let collectionToDelete = selectedCollection {
            viewContext.delete(collectionToDelete)
            
            do {
                try viewContext.save()
                
            } catch {
                print("Error deleting collection: \(error)")
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchImage() {
        Task {
            if let data = try? await photosPickerItem?.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    self.selectedCollectionImage = uiImage
                }
            }
        }
    }
}
