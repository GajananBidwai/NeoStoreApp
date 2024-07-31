//
//  LoginViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 28/07/24.
//

import Foundation
enum LoginEvent{
    case Loading
    case StopLoading
    case DataLoaded
    case Error(Error?)
}

class LoginViewModel{
    var login : Login?
    var eventHandler: ((_ event : LoginEvent)-> Void)?
    func login(parameters : [String : String]){
        eventHandler?(.Loading)
        ApiHelpers.postURL(url: Constant.Api.loginUrl, param: parameters, headers: .URLEncoded, module: Login.self) { [self] result in
            self.eventHandler?(.StopLoading)
            self.login = result
            let accessToken = login?.data.accessToken
            UserDefaults.standard.set(accessToken, forKey: "access_token")
            let name = login?.data.firstName
            UserDefaults.standard.set(name,forKey: "name")
            self.eventHandler?(.DataLoaded)
            print(result.data)
        } Failuer: { error in
            self.eventHandler?(.Error(error))
        }
    }
}
