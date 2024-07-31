//
//  ProductListingsViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 17/07/24.
//

import Foundation

class ProductListingsViewModel{
    
    var productcategoryid : String?
    var table : Table?
   
    var eventHandler: ((_ event : Event)-> Void)? // Data binding
    func fetchProduct(){
        let param: [String: String] = ["product_category_id": productcategoryid!]
        self.eventHandler?(.loading)
        ApiHelpers.getApi(url: Constant.Api.productList, module: Table.self, paramter: param) { Response in
            self.eventHandler?(.stopLoading)
            self.table = Response
            self.eventHandler?(.dataloaded)
        } Failure: { error in
            self.eventHandler?(.error(error))
        }
        
    }
}
extension ProductListingsViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataloaded
        case error(Error?)
    }
}
