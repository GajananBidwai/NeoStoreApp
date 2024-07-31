//
//  User.swift
//  NeoStoreApp
//
//  Created by Neosoft on 28/06/24.
//

import Foundation
struct User : Decodable{
    var data : dataObject
}

struct dataObject : Decodable{
    var user_data : UserData
}
struct UserData : Decodable{
    var first_name : String
    var last_name : String
    var email : String
    var phone_no : String
    var dob : String?
  
}
