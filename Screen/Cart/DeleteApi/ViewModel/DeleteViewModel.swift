////
////  DeleteViewModel.swift
////  NeoStoreApp
////
////  Created by Neosoft on 26/07/24.
////
//
//import Foundation
//enum deletingEvent{
//    case Loading
//    case StopLoading
//    case DataLoaded
//    case Error(Error?)
//}
//class DeleteViewModel{
//    var deleteCart : DeleteCart?
//    var eventHandler: ((_ event : deletingEvent)->Void)?
//
//    func deleteData(parameter : [String :  String] , productId: String, indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
//       // let parameter: [String: String] = ["product_id": productId]
//        eventHandler?(.Loading)
//        ApiHelpers.postURL(url: Constant.Api.deletingUrl, param: parameter, headers: .URLEncoded, module: DeleteCart.self) { Response in
//            self.eventHandler?(.StopLoading)
//            self.deleteCart = Response
//            self.eventHandler?(.DataLoaded)
/// contextual error is coming due to that completion handler is not calling in the same VC
//            completion(true)
//        } Failuer: { error in
//            completion(false)
//            self.eventHandler?(.Error(error))
//        }
//    }
//}
