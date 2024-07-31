//
//  MyCart.swift
//  NeoStoreApp
//
//  Created by Neosoft on 04/07/24.
//

import Foundation
struct MyCart : Decodable{
    var status : Int
    var data : [dataArray]
}
struct dataArray : Decodable{
    var id : Int
    var product_id : Int
    var quantity : Int
    var product : product
}
struct product : Decodable{
    var name : String
    var cost : Int
    var product_category : String
    var product_images : String
}
