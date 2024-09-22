//
//  AddNewCollection.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import PhotosUI
import SwiftUI

struct AddNewCollection: View {
    // MARK: - Public Propertis

    @Environment(\.dismiss) var dismiss
    @State var selectedCollectionCategory: CategoryEntity?
    
    // MARK: - Private Properties

    @StateObject private var viewModel = AddNewCollectionViewModel()

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                headerView
                collectionInfoView
                imageSection
                formFields
                createButton
            }
            .padding(.horizontal)
            .photosPicker(
                isPresented: $viewModel.isPhotoLibraryPresented,
                selection: $viewModel.photosPickerItem
            )
            .onAppear {
                viewModel.selectedCollectionCategory = selectedCollectionCategory
            }
        }
    }
    
    // MARK: - Private Properties

    private var headerView: some View {
        Text("Add a new collection")
            .font(.system(size: 24, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var collectionInfoView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("\(selectedCollectionCategory?.name ?? "")/")
                .foregroundColor(.secondaryForeground.opacity(0.5))
                .font(.system(size: 18, weight: .semibold))
                + Text("\(selectedCollectionCategory?.categoryType ?? "")")
                .foregroundColor(.primaryForeground)
                .font(.system(size: 18, weight: .semibold))
            
            backButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var backButton: some View {
        Button(action: { dismiss() }) {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.primaryForeground)
                
                Text("Back")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.primaryForeground)
            }
        }
    }
    
    private var imageSection: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("Add an image")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primaryForeground)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RoundedRectangle(cornerRadius: 24)
                .stroke(.primaryForeground, lineWidth: 2)
                .frame(width: 180, height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundStyle(.tertiaryForeground.opacity(0.5))
                        .overlay(imageOverlay)
                )
        }
    }
    
    private var imageOverlay: some View {
        Button(action: { viewModel.isPhotoLibraryPresented.toggle() }) {
            if let image = viewModel.selectedCollectionImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .clipped()
                    .overlay(Image.importImage)
            } else {
                Image.importImage
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(viewModel.selectedCollectionImage != nil ? .clear : .tertiaryForeground)
        )
    }
    
    private var formFields: some View {
        ScrollView {
            AppTextField(
                text: $viewModel.collectionName,
                title: "Collection name",
                placeholder: "Name"
            )
            AppTextField(
                text: $viewModel.collectionCost,
                title: "Cost",
                placeholder: "0$"
            )
            AppTextField(
                text: $viewModel.collectionDate,
                title: "Year",
                placeholder: "12/12/2001"
            )
            CategoryDropdown(selectedCategoryType: $viewModel.selectedCollectionType)
        }
    }
    
    private var createButton: some View {
        PrimaryButton(
            title: "Create",
            action: handleCreateAction
        )
        .disabled(isCreateButtonDisabled)
    }
    
    private func handleCreateAction() {
        viewModel.addCollection()
        dismiss()
    }
    
    private var isCreateButtonDisabled: Bool {
        viewModel.collectionCost.isEmpty || viewModel.collectionDate.isEmpty ||
            viewModel.collectionName.isEmpty || viewModel.selectedCollectionType == nil ||
            viewModel.selectedCollectionImage == nil
    }
}
