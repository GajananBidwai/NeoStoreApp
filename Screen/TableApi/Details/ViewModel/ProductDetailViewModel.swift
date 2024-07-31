//
//  DetailViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 17/07/24.
//

import Foundation
enum ProductDetailsEvent{
    case Loading
    case Stoploading
    case DataLoaded
    case Error(Error?)
}
class ProductDetailViewModel {
    var productDetails : ProductDetails?
    var eventHandler : ((_ event : Event)->Void)?
    func fetchData(productId : [String : Any]){
        eventHandler?(.Loading)
        ApiHelpers.getApi(url: Constant.Api.productDetails, module: ProductDetails.self, paramter: productId) { Response in
            self.eventHandler?(.StopLoading)
            self.productDetails = Response
            self.eventHandler?(.dataLoaded)
        } Failure: { error in
            self.eventHandler?(.Error(error))
        }
    }
}
