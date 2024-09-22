//
//  AddNewCategory.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import PhotosUI
import SwiftUI

struct AddNewCategory: View {
    // MARK: - Public Propertis

    @Environment(\.dismiss) var dismiss
    @State var isFirstOpen: Bool

    // MARK: - Private Properties

    @StateObject private var viewModel = AddCategoryViewModel()

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 38) {
                headerView
                imageSection
                formFields
                createButton
            }
            .padding(.horizontal)
            .photosPicker(
                isPresented: $viewModel.isPhotoLibraryPresented,
                selection: $viewModel.photosPickerItem
            )
            .navigationDestination(isPresented: $viewModel.isFinishPresented) {
                FinishCreateCategory()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }

    // MARK: - Private Properties

    private var headerView: some View {
        Text("Add a new category")
            .font(.system(size: 24, weight: .semibold))
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
        VStack(alignment: .center, spacing: 38) {
            Text("Add an image")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primaryForeground)
                .frame(maxWidth: .infinity, alignment: .leading)

            RoundedRectangle(cornerRadius: 24)
                .stroke(.primaryForeground, lineWidth: 2)
                .frame(width: 180, height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundStyle(.tertiaryForeground.opacity(0.5)))
                .overlay(imageOverlay)
        }
    }

    private var imageOverlay: some View {
        Button(action: { viewModel.isPhotoLibraryPresented.toggle() }) {
            if let image = viewModel.selectedImage {
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
                .foregroundStyle(viewModel.selectedImage != nil ? .clear : .tertiaryForeground)
        )
    }

    private var formFields: some View {
        ScrollView {
            AppTextField(
                text: $viewModel.categoryName,
                title: "Category name",
                placeholder: "Name"
            )

            CategoryDropdown(selectedCategoryType: $viewModel.selectedCategoryType)
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
        viewModel.saveCollection()
        if isFirstOpen {
            viewModel.isFinishPresented.toggle()
            isFirstOpen = false
        } else {
            dismiss()
        }
    }

    private var isCreateButtonDisabled: Bool {
        viewModel.categoryName.isEmpty || viewModel.selectedCategoryType == nil || viewModel.selectedImage == nil
    }
}

#Preview {
    AddNewCategory(isFirstOpen: true)
}
