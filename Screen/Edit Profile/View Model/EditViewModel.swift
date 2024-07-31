//
//  EditViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 29/07/24.
//

import Foundation
enum editEvent{
    case Loading
    case StopLoading
    case DataLoaded
    case Error(Error?)
}
class EditViewModel{
    var getData: GetData?
    var eventHandler: ((_ event : editEvent)-> Void)?
    
    func fetchData(parameters : [String : String]){
        self.eventHandler?(.Loading)
        ApiHelpers.postURL(url: Constant.Api.updateAccountDetails, param: parameters, headers: .URLEncoded, module: GetData.self, isAccessTokenRequired: true) { Result in
            self.eventHandler?(.StopLoading)
            self.getData = Result
            self.eventHandler?(.DataLoaded)
        } Failuer: { error in
            print(error!)
            self.eventHandler?(.Error(error))
        }

    }
}
