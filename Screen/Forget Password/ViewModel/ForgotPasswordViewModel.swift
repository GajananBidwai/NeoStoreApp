//
//  ForgotPasswordViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 26/07/24.
//

import Foundation
enum forGotPasswordEvent{
    case Loading
    case StopLoading
    case DataLoaded
    case Error
}

class ForgotPasswordViewModel{
    var forgetPassword : ForgetPassword?
    var eventHandler : ((_ event : forGotPasswordEvent)-> Void)?
    func fetchForgotUrl(paramters : [String : String]){
        eventHandler?(.Loading)
        ApiHelpers.postURL(url: Constant.Api.forgetPasswordUrl, param: paramters, headers: .URLEncoded, module: ForgetPassword.self) { result in
            self.eventHandler?(.StopLoading)
            self.forgetPassword = result
            self.eventHandler?(.DataLoaded)
        } Failuer: { error in
            self.eventHandler?(.Error)
        }
    }
}
