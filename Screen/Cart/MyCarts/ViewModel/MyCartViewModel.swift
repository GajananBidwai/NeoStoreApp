//
//  MyCartViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 26/07/24.
//

import Foundation

enum CartEvent{
    case loading
    case StopLoading
    case Dataloaded
    case Error(Error?)
}
class MyCartViewModel{
    var myCart : MyCart?
    var price : Int?
    var eventHandler : ((_ event : CartEvent)-> Void)?
    func fetchData(){
        eventHandler?(.loading)
        ApiHelpers.getApi(url: Constant.Api.listCartItems, module: MyCart.self, paramter: [:]) { Response in
            self.eventHandler?(.StopLoading)
            self.myCart = Response
            print(self.myCart)
            self.eventHandler?(.Dataloaded)
        } Failure: { error in
            self.eventHandler?(.Error(error))
        }
    }
    func getPrice(for index: Int) -> Int? {
        return myCart?.data[index].product.cost
    }
}


