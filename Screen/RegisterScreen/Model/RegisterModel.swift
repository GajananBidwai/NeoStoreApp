//
//  Reg.swift
//  NeoStoreApp
//
//  Created by Neosoft on 01/07/24.
//

import Foundation

struct RegisterModel: Codable {
    let status: Int
    let data: RegisterData
    let message, userMsg: String

    enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMsg = "user_msg"
    }
}

// MARK: - DataClass
struct RegisterData: Codable {
    let id, roleID: Int
    let firstName, lastName, email, username: String
    let gender: String
    let phoneNo: String
    let isActive: Bool
    let created, modified: String
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case id
        case roleID = "role_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, username
        case gender
        case phoneNo = "phone_no"
        case isActive = "is_active"
        case created, modified
        case accessToken = "access_token"
    }
}
