//
//  ProductDetails.swift
//  NeoStoreApp
//
//  Created by Neosoft on 02/07/24.
//

import Foundation
struct ProductDetails: Codable {
    var status: Int
    var data: DataClass
}
struct DataClass: Codable {
    var id : Int
    var product_category_id : Int
    let name : String
    var producer : String
    var description: String
    let cost : Int
    var rating : Int
    var view_count : Int
    let created : String
    var modified: String
    var product_images: [ProductImage]
}
struct ProductImage: Codable {
    let id : Int
    var product_id : Int
    let image: String
    let created : String
    var modified: String

}
