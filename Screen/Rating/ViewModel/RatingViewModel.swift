//
//  RatingViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 20/07/24.
//

import Foundation
class RatingViewModel{
    var ratingApi: RatingApi?
    var productId : Int?
    var eventHandler : ((_ event : Event)-> Void)?
    func fetchData(productId: String){
        let paramters = ["product_id" : "\(productId)"]
        self.eventHandler?(.Loading)
        ApiHelpers.postURL(url: Constant.Api.ratingUrl, param: paramters, headers: .URLEncoded, module: RatingApi.self) { Response in
            self.eventHandler?(.StopLoading)
            self.ratingApi = Response
            print(Response)
            self.eventHandler?(.dataLoaded)
        } Failuer: { error in
            self.eventHandler?(.Error(error))
        }
    }
}
enum Event{
    case Loading
    case StopLoading
    case dataLoaded
    case Error(Error?)
}
