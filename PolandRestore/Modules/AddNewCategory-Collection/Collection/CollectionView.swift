//
//  CollectionView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 20.09.2024.
//

import SwiftUI

struct CollectionView: View {
    @StateObject private var viewModel = AddNewCollectionViewModel()
    @Environment(\.dismiss) var dismiss
    var collection: CollectionEntity?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text("\(collection?.name ?? "")/")
                .foregroundColor(.secondaryForeground)
                .font(.system(size: 24, weight: .semibold))
                + Text("\(collection?.categoryType?.lowercased() ?? "")")
                .foregroundColor(.primaryForeground)
                .font(.system(size: 24, weight: .semibold))
                    
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
            
            VStack(alignment: .center) {
                if let imageData = collection?.image, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 180, height: 200)
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
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 12) {
                    Text("Year")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(Color.secondaryForeground.opacity(0.25))
                }
                .padding(.leading, 5)
                
                Text(collection?.year ?? " ")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.primaryForeground, lineWidth: 2)
                    )
                    .font(.system(size: 18, weight: .semibold))
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 12) {
                    Text("Category type")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(Color.secondaryForeground.opacity(0.25))
                }
                .padding(.leading, 5)
                
                Text(collection?.categoryType ?? " ")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.primaryForeground, lineWidth: 2)
                    )
                    .font(.system(size: 18, weight: .semibold))
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                viewModel.isDeletePopupPresent.toggle()
            }) {
                Image("broom")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.primaryText)
                    .padding()
                    .background {
                        Circle()
                            .foregroundStyle(.primaryForeground)
                    }
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
        .deleteMessage(
            isPresented: $viewModel.isDeletePopupPresent,
            onTapYes: {
                viewModel.selectedCollection = collection
                viewModel.deleteCollection()
                dismiss()
            }
        )
    }
}

#Preview {
    CollectionView()
}
