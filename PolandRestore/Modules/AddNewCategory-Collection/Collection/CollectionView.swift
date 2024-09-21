//
//  CollectionView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct CollectionView: View {
    // MARK: - Public Propertis

    @Environment(\.dismiss) var dismiss
    var collection: CollectionEntity?
    
    // MARK: - Private Properties

    @StateObject private var viewModel = AddNewCollectionViewModel()
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 13) {
                VStack(alignment: .leading, spacing: 13) {
                    headerView
                    backButton
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                collectionImageSection
                collectionDetails
                deleteButton
            }
            .padding(.horizontal)
            .deleteMessage(
                isPresented: $viewModel.isDeletePopupPresent,
                onTapYes: handleDelete
            )
        }
    }
    
    // MARK: - Private Properties

    private var headerView: some View {
        Text("\(collection?.name ?? "")/")
            .foregroundColor(.secondaryForeground)
            .font(.system(size: 24, weight: .semibold))
            + Text(collection?.categoryType?.lowercased() ?? "")
            .foregroundColor(.primaryForeground)
            .font(.system(size: 24, weight: .semibold))
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
    
    private var collectionImageSection: some View {
        VStack(alignment: .center) {
            if let imageData = collection?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 170, height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .secondaryForeground.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            Text(collection?.name ?? "")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primaryForeground)
                .padding(.top, 8)
            
            Text(collection?.categoryType ?? "")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.secondaryForeground)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
    }
    
    private var collectionDetails: some View {
        VStack(alignment: .leading, spacing: 35) {
            detailSection(title: "Year", value: collection?.year)
            detailSection(title: "Category type", value: collection?.categoryType)
        }
        .padding(.horizontal)
    }
    
    private func detailSection(title: String, value: String?) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Color.secondaryForeground.opacity(0.25))
            }
            .padding(.leading, 5)
            
            Text(value ?? " ")
                .frame(maxWidth: .infinity, alignment: title == "Year" ? .leading : .center)
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primaryForeground, lineWidth: 2)
                )
                .font(.system(size: 18, weight: .semibold))
        }
    }
    
    private var deleteButton: some View {
        Button(action: { viewModel.isDeletePopupPresent.toggle() }) {
            Image("broom")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundStyle(.primaryText)
                .padding()
                .background(Circle().foregroundStyle(.primaryForeground))
                .padding(.top, 100)
        }
    }
    
    private func handleDelete() {
        viewModel.selectedCollection = collection
        viewModel.deleteCollection()
        dismiss()
    }
}

#Preview {
    CollectionView()
}
