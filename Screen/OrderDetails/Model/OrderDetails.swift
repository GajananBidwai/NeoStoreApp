//
//  OrderDetails.swift
//  NeoStoreApp
//
//  Created by Neosoft on 08/07/24.
//

import Foundation

struct OrderDetails : Decodable{
    var status : Int
    var data : DataDetails
}
struct DataDetails : Decodable{
    var id : Int
    var cost : Int
    var address : String
    var order_details : [Order]
}
struct Order : Decodable{
    var id : Int
    var order_id : Int
    var quantity : Int
    var total : Int
    var prod_name : String
    var prod_cat_name : String
    var prod_image : String
}

