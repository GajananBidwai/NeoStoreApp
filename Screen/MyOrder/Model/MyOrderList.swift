//
//  MyOrderList.swift
//  NeoStoreApp
//
//  Created by Neosoft on 02/07/24.
//

import Foundation

struct MyOrderList : Decodable{
    var data : [OrderData]
}
struct OrderData : Decodable{
    var id : Int
    var cost : Int
    var created : String
}
