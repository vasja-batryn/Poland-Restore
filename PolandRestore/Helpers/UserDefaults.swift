//
//  UserDefaults.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 16.09.2024.
//

import Foundation

enum UserDefaultsKey: String {
    // MARK: - Cases

    case showOnboarding
}

// MARK: - UserDefaults+UserDefaultsKey

extension UserDefaults {
    func set(value: Any?, forKey key: UserDefaultsKey) {
        setValue(value, forKey: key.rawValue)
    }

    func string(forKey key: UserDefaultsKey) -> String? {
        value(forKey: key.rawValue) as? String
    }
}

class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var user: User?

    private let userKey = "savedUser"

    init() {
        user = loadUser()
    }

    func saveUser(_ user: User) {
        if let encodedUser = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: userKey)
            self.user = user
        }
    }

    func loadUser() -> User? {
        if let savedUserData = UserDefaults.standard.data(forKey: userKey) {
            if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
                return decodedUser
            }
        }
        return nil
    }

    func updateUserCollectionCount() {
        if var currentUser = user {
            currentUser.collectionCount += 1
            saveUser(currentUser)
        }
    }
}
