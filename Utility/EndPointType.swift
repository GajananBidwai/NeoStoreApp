//
//  EndPointType.swift
//  NeoStoreApp
//
//  Created by Neosoft on 17/07/24.
//

import Foundation

enum HTTPMethods : String{
    case get = "GET"
    case post = "POST"
}

protocol EndPointType{
   
    var baseUrl : String { get }
    var method : HTTPMethods { get }
    var body : [String : String]? { get }
}
