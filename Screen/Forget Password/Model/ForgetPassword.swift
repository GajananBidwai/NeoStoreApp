//
//  ForgetPassword.swift
//  NeoStoreApp
//
//  Created by Neosoft on 28/07/24.
//

import Foundation
struct ForgetPassword: Codable {
    let status: Int
    let message, userMsg: String

    enum CodingKeys: String, CodingKey {
        case status, message
        case userMsg = "user_msg"
    }
}
