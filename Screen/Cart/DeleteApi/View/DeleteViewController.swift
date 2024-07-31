////
////  DeleteViewController.swift
////  NeoStoreApp
////
////  Created by Neosoft on 05/07/24.
////
//
//import UIKit
//import Foundation
//class DeleteViewController: UIViewController {
//    var viewModel = DeleteViewModel()
//    var productId : Int?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//}
//extension DeleteViewController{
//    func configuration(){
//      //  initiViewModel()
//        eventHandler()
//    }
////    func initiViewModel(){
////        let parameters : [String : String] = ["product_id": "\(productId)"]
////        viewModel.deleteData(parameter: parameters, productId: "\(productId)", indexPath: <#T##IndexPath#>, completion: <#T##(Bool) -> Void#>)
////    }
//    func eventHandler(){
//        viewModel.eventHandler = {
//            Response in
//            switch Response{
//            case .Loading:
//                print("Start Loading")
//            case .StopLoading:
//                print("Stop Loading")
//            case .DataLoaded:
//                print("Data loaded")
//            case .Error(let error):
//                print(error)
//            }
//        }
//    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
//            guard let self = self else { return }
//            guard let productId = self.myCart?.data[indexPath.row].product_id else {
//                completionHandler(false)
//                return
//            }
//
//            self.deleteData(productId: "\(productId)", indexPath: indexPath) { success in
//                if success {
//                    DispatchQueue.main.async {
//                        self.myCart?.data.remove(at: indexPath.row)
//                        tableView.deleteRows(at: [indexPath], with: .automatic)
//                        completionHandler(true)
//
//                        if self.myCart?.data.isEmpty ?? true {
//                            self.showAlert()
//                        }
//                    }
//                } else {
//                    completionHandler(false)
//                }
//            }
//        }
//
//        deleteAction.image = UIImage(named: "delete")
//        deleteAction.backgroundColor = .red
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
//
//
//    func showAlert(){
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: "Cart", message: "Your Cart is Empty", preferredStyle: .alert)
//            let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
//                let HomeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
//                self.navigationController?.pushViewController(HomeScreenViewController, animated: true)
//            }
//            alert.addAction(okayAction)
//            self.present(alert, animated: true)
//        }
//    }
//}
