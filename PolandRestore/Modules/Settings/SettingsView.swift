//
//  SettingsView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Public Propertis

    @StateObject var viewModel = SettingsViewModel()

    // MARK: - Private Properties

    @State private var userName: String = ""
    @State private var collectionCount: Int = 0
    @State private var avatar: UIImage? = UIImage(named: "User")

    // MARK: - Body

    var body: some View {
        VStack(spacing: 50) {
            headerView
            userInfoSection
            SettingsListView()
                .padding(.vertical)
            Spacer()
        }
        .padding(.horizontal)
        .onAppear(perform: loadUserData)
        .photosPicker(
            isPresented: $viewModel.isPhotoLibraryPresented,
            selection: $viewModel.photosPickerItem
        )
        .onChange(of: viewModel.selectedImage, perform: handleImageChange)
    }

    // MARK: - Private Properties

    private var headerView: some View {
        Text("Settings")
            .font(.system(size: 24, weight: .semibold))
            .foregroundStyle(.primaryForeground)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var userInfoSection: some View {
        VStack {
            if let avatar = avatar {
                Image(uiImage: avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .clipShape(Circle())
                    .overlay(editAvatarButton)
            }

            Text(userName)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(.primaryForeground)
                .overlay(editNameButton)
        }
    }

    private var editAvatarButton: some View {
        Group {
            if viewModel.isEditMode {
                Button(action: { viewModel.isPhotoLibraryPresented.toggle() }) {
                    Image("importImage")
                }
            }
        }
    }

    private var editNameButton: some View {
        Button(action: { viewModel.isEditMode.toggle() }) {
            Image(viewModel.isEditMode ? "pencilActive" : "pencil")
        }
        .offset(x: 35, y: -10)
    }

    // MARK: - Private Methods

    private func loadUserData() {
        if let user = UserManager.shared.loadUser() {
            userName = user.name
            collectionCount = user.collectionCount
            avatar = viewModel.loadAvatarFromUserDefaults() ?? UIImage(named: "User")
        } else {
            userName = "Unknown"
            collectionCount = 0
        }
    }

    private func handleImageChange(newImage: UIImage?) {
        if let newImage = newImage {
            avatar = newImage
        }
    }
}

#Preview {
    SettingsView()
}
