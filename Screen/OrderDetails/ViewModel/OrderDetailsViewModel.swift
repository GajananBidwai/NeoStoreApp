//
//  OrderDetailsViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 21/07/24.
//

import Foundation
class OrderDetailsViewModel{
    
    var orderId : Int?
    var orderDetails : OrderDetails?
    var eventHandler : ((_ event : EventHander)->Void)?
    
    func fetchData(){
        self.eventHandler?(.Loading)
        let paramters: [String : String] = ["order_id": "\(orderId ?? 0)"]
        ApiHelpers.getApi(url: Constant.Api.orderDetails, module: OrderDetails.self, paramter: paramters) { Response in
            self.eventHandler?(.StopLoading)
            self.orderDetails = Response
            self.eventHandler?(.dataLoaded)
        } Failure: { error in
            self.eventHandler?(.error(error))
        }
    }
}
enum EventHander{
    case Loading
    case StopLoading
    case dataLoaded
    case error(Error?)
}
