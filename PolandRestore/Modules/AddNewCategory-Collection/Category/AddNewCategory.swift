//
//  AddNewCategory.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import PhotosUI
import SwiftUI

struct AddNewCategory: View {
    @StateObject private var viewModel = AddCategoryViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var isfirstOpen: Bool
    @State var isCollection: Bool = false

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Add a new category")
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            if isCollection {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(viewModel.categoryName)/\(viewModel.selectedCategoryType)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.primaryForeground)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
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
            }
            
            Text("Add an image")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primaryForeground)
                .frame(maxWidth: .infinity, alignment: .leading)

            RoundedRectangle(cornerRadius: 24)
                .stroke(.primaryForeground, lineWidth: 2)
                .frame(width: 180, height: 200)
                .overlay(alignment: .center) {
                    Button(action: { viewModel.isPhotoLibraryPresented.toggle() }) {
                        Image("importImage")
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundStyle(viewModel.selectedImage != nil ? .clear : .tertiaryForeground.opacity(0.5))
                        .background {
                            if let image = viewModel.selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                        }
                }
                .padding(.vertical)
                
            ScrollView {
                AppTextField(
                    text: $viewModel.categoryName,
                    title: "Category name",
                    placeholder: "Name"
                )
                
                CategoryDropdown(selectedCategoryType: $viewModel.selectedCategoryType)
            }
            
            PrimaryButton(
                title: "Create",
                action: {
                    viewModel.saveCollection()
                    
                    if isfirstOpen == true {
                        viewModel.isFinishPresented.toggle()
                        isfirstOpen = false
                    } else {
                        dismiss()
                    }
                }
            )
            .disabled(
                viewModel.categoryName.isEmpty || viewModel.selectedCategoryType == nil || viewModel.selectedImage == nil
            )
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

#Preview {
    AddNewCategory(isfirstOpen: true)
}
