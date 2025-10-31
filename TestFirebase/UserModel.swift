//
//  UserModel.swift
//  TestFirebase
//
//  Created by Гость on 30.10.2025.
//

import Foundation

struct UserModel: Codable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
}
