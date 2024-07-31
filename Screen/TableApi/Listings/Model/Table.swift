//
//  Table.swift
//  NeoStoreApp
//
//  Created by Neosoft on 01/07/24.
//

import Foundation
struct Table : Decodable{
    var status : Int
    var data : [Data]
}

struct Data : Decodable{
    var product_category_id : Int
    var name : String
    var producer : String
    var cost : Int
    var rating : Int
    var product_images : String
    var id : Int
}
