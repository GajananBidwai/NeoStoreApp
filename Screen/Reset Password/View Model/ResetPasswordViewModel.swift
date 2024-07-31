//
//  ResetPasswordViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 18/07/24.
//

import Foundation
class ResetPasswordViewModel{
    
    
    var resetPassword : ResetPassword?
    var eventHandler: ((_ event : Event)-> Void)?
    func fetchData(parameters : [String : String]){
        
        self.eventHandler?(.Laading)
        ApiHelpers.postURL(url: Constant.Api.resetPasswordUrl, param: parameters, headers: .URLEncoded, module: ResetPassword.self) { Response in
            self.eventHandler?(.StopLoading)
            self.resetPassword = Response
            self.eventHandler?(.DataLoaded)
        } Failuer: { error in
            self.eventHandler?(.Error(error))
            print(error)
        }
        

    }
    
}
extension ResetPasswordViewModel{
    enum Event{
        case Laading
        case StopLoading
        case DataLoaded
        case Error(Error?)
    }
}
