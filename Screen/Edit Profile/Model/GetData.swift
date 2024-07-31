//
//  GetData.swift
//  NeoStoreApp
//
//  Created by Neosoft on 10/07/24.
//

import Foundation
struct GetData: Codable {
    var status: Int
    var data: UserDataClass
}

// MARK: - DataClass
struct UserDataClass: Codable {
    var user_data: GetUserData
    var product_categories: [ProductCategory]
    var total_carts : Int
    var total_orders: Int

}
// MARK: - ProductCategory

struct ProductCategory: Codable {
    var id: Int
    var name : String
    var icon_image : String
    var created : String
    var modified : String
}
struct GetUserData: Codable {
    var id : Int
    var role_id: Int
    var first_name : String
    var last_name : String
    var email : String
    var username: String
    var profile_pic : String?
    var gender : String
    var phone_no: String
    var dob: String?
    var is_active: Bool
    var created : String
    var modified: String
    var access_token: String


}
