//
//  SettingsView.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @State private var userName: String = ""
    @State private var collectionCount: Int = 0
    @State private var avatar: UIImage? = UIImage(named: "User")

    var body: some View {
        VStack(spacing: 50) {
            Text("Settings")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(.primaryForeground)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                if let avatar = avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .overlay(alignment: .center) {
                            if self.viewModel.isEditMode {
                                Button(action: { self.viewModel.isPhotoLibraryPresented.toggle() }) {
                                    Image("importImage")
                                }
                            }
                        }
                }

                Text(self.userName)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.primaryForeground)
                    .overlay(alignment: .trailing) {
                        Button(action: {
                            self.viewModel.isEditMode.toggle()
                        }) {
                            Image(self.viewModel.isEditMode ? "pencilActive" : "pencil")
                                .offset(x: 20, y: -10)
                        }
                    }
            }

            SettingsListView()
                .padding(.vertical)

            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            self.loadUserData()
        }
        .photosPicker(
            isPresented: self.$viewModel.isPhotoLibraryPresented,
            selection: self.$viewModel.photosPickerItem
        )
        .onChange(of: self.viewModel.selectedImage) { newImage in
            if let newImage = newImage {
                self.avatar = newImage
            }
        }
    }

    private func loadUserData() {
        if let user = UserManager.shared.loadUser() {
            self.userName = user.name
            self.collectionCount = user.collectionCount
            if let avatar = viewModel.loadAvatarFromUserDefaults() {
                self.avatar = avatar
            } else {
                self.avatar = UIImage(named: "User")
            }
        } else {
            self.userName = "Unknown"
            self.collectionCount = 0
        }
    }
}

#Preview {
    SettingsView()
}
