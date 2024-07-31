//
//  Rating.swift
//  NeoStoreApp
//
//  Created by Neosoft on 16/07/24.
//

import Foundation
struct RatingApi: Codable {
    let status: Int
    let data: RatingDataClass
    let message : String
    let user_msg: String

    
}

// MARK: - DataClass
struct RatingDataClass: Codable {
    let id, product_category_id: Int
    let name, producer, description: String
    let cost: Int
    let rating: Double
    let view_count: Int
    

    
}
