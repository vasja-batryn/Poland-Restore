//
//  AddNewCollection.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import PhotosUI
import SwiftUI

struct AddNewCollection: View {
    @StateObject private var viewModel = AddNewCollectionViewModel()
    @Environment(\.dismiss) var dismiss
    @State var selectedCollectionCategory: CategoryEntity?
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Add a new category")
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 20) {
                Text("\(selectedCollectionCategory?.name ?? "")/")
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
                        .foregroundStyle(viewModel.selectedCollectionImage != nil ? .clear : .tertiaryForeground.opacity(0.5))
                        .background {
                            if let image = viewModel.selectedCollectionImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                        }
                }
                .padding(.vertical)
                
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
            
            PrimaryButton(
                title: "Create",
                action: {
                    viewModel.addCollection()
                    
                    dismiss()
                }
            )
            .disabled(
                viewModel.collectionCost.isEmpty || viewModel.collectionDate.isEmpty || viewModel.collectionName.isEmpty || viewModel.selectedCollectionType == nil || viewModel.selectedCollectionImage == nil
            )
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
