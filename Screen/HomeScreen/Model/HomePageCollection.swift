//
//  HomePageCollection.swift
//  NeoStoreApp
//
//  Created by Neosoft on 12/07/24.
//

import Foundation

struct HomePageCollection: Codable {
    let status: Int
    let data: HomeData
}
struct HomeData: Codable {
    let user_data: UserHomeData
    let product_categories: [ProductCategories]
    let total_carts : Int
    let total_orders: Int
}
struct ProductCategories: Codable {
    let id: Int
    let name: String
    let icon_image: String
}
struct UserHomeData: Codable {
    let id : Int
    let role_id: Int
    let first_name : String
    let last_name : String
    let email : String
    let username: String
    let gender : String
    let phone_no: String
    let access_token: String

    
}
