//
//  Login.swift
//  NeoStoreApp
//
//  Created by Neosoft on 08/07/24.
//

import Foundation
struct Login : Codable {
    let status: Int
    let data: LoginData
    
}
// MARK: - DataClass
struct LoginData : Codable {
    let id : Int
    let firstName : String
    let lastName :  String
    let email : String
    let username: String
    let gender : String
    let phoneNo: String
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, username
        case gender
        case phoneNo = "phone_no"
        case accessToken = "access_token"
    }
}
