//
//  EditCartViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 29/07/24.
//

import Foundation
enum EditCartEvent{
    case loading
    case StopLoading
    case Dataloaded
    case Error(Error?)
}
class EditCartViewModel{
    var editCart : EditCart?
    var eventHandler : ((_ event : EditCartEvent)-> Void)?
    func updateCart(paramters : [String : String]){
        eventHandler?(.loading)
        ApiHelpers.postURL(url: Constant.Api.editCart, param: paramters, headers: .URLEncoded, module: EditCart.self) { Response in
            self.eventHandler?(.StopLoading)
            self.editCart = Response
            self.eventHandler?(.Dataloaded)
        } Failuer: { error in
            self.eventHandler?(.Error(error))
            print(error)
        }
    }
}
