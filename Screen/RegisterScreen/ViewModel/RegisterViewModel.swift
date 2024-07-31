//
//  RegisterViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 18/07/24.
//

import Foundation
class RegisterViewModel{
    
    
    var eventHandler : ((_ event : Event)-> Void)?
    var registerModel : RegisterModel?
    func fetchData(parameters : [String : String]){
        eventHandler?(.Loading)
        ApiHelpers.postURL(url: Constant.Api.registerUrl, param: parameters, headers: .URLEncoded, module: RegisterModel.self) { Response in
            self.eventHandler?(.Stoploading)
            self.registerModel = Response
            self.eventHandler?(.DataLoadeded)
        } Failuer: { error in
            self.eventHandler?(.error(error))
        }

    }
}
extension RegisterViewModel{
    enum Event{
        case Loading
        case Stoploading
        case DataLoadeded
        case error(Error?)
    }
}
