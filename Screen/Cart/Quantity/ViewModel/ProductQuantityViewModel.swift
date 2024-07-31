//
//  ProductQunatityViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 28/07/24.
//

import Foundation
enum QuantityEvent{
    case Loading
    case StopLoading
    case DataLoaded
    case Error(Error?)
}
class ProductQuantityViewModel{
    var addToCart : AddToCart?
    var eventHander : ((_ event : QuantityEvent)-> Void)?
    func fetchQuantity(parameters : [String : String]){
        self.eventHander?(.Loading)
        ApiHelpers.postURL(url: Constant.Api.addToCart, param: parameters, headers: .URLEncoded, module: AddToCart.self) { result in
            self.eventHander?(.StopLoading)
            self.addToCart = result
            self.eventHander?(.DataLoaded)
        } Failuer: { error in
            self.eventHander?(.Error(error))
        }
    }
}
