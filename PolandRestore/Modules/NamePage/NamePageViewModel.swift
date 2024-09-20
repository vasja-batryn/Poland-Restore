//
//  NamePageViewModel.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import SwiftUI

final class NamePageViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var avatar: UIImage? = UIImage(named: "User")
    @Published var collectionCount: Int = 0
    @Published var showHelloPage: Bool = false
    
    private let userKey = "savedUser"
        
    init() {
        self.loadUser()
    }
    
    func saveUser() {
        let avatarData = self.avatar?.pngData()
        let user = User(name: name, collectionCount: collectionCount, avatar: avatarData)
        UserManager.shared.saveUser(user)
    }
        
    func loadUser() {
        if let user = UserManager.shared.loadUser() {
            self.name = user.name
            self.collectionCount = user.collectionCount
            if let avatarData = user.avatar {
                self.avatar = UIImage(data: avatarData)
            }
        }
    }
}
