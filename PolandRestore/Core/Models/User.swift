//
//  User.swift
//  PolandRestore
//
//  Created by Vasja Batryn on 19.09.2024.
//

import SwiftUI

struct User: Codable {
    var name: String
    var collectionCount: Int
    var avatar: Data?
}
