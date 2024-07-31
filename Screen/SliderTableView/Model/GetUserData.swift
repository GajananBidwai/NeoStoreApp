//
//  GetUserData.swift
//  NeoStoreApp
//
//  Created by Neosoft on 16/07/24.
//

import Foundation

struct GetUserData1 : Decodable{
    var data : userDataObject
}

struct userDataObject : Decodable{
    var user_data : UserDataResponse
}
struct UserDataResponse : Decodable{
    var first_name : String
    var last_name : String
    var email : String
    var phone_no : String
    var dob : String?
  
}
