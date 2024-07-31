//
//  MyOrderViewModel.swift
//  NeoStoreApp
//
//  Created by Neosoft on 21/07/24.
//

import Foundation
class MyOrderViewModel{
    var myOrderList : MyOrderList?
    var eventHandler: ((_ event : OrderHandler)->Void)?
    
    func fetchOrder(){
        eventHandler?(.Loading)
        ApiHelpers.getApi(url: Constant.Api.orderListApi, module: MyOrderList.self, paramter: [:],isAccessTokenRequired: true) { Response in
            self.eventHandler?(.StopLoading)
            var temp = Response
            temp.data = Response.data.reversed()
            self.myOrderList = temp
            self.eventHandler?(.DataLoaded)
        } Failure: { error in
            self.eventHandler?(.error(error))
        }
    }
}
enum OrderHandler{
    case Loading
    case StopLoading
    case DataLoaded
    case error(Error?)
}
