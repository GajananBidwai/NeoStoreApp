//
//  MyOrderViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 02/07/24.
//

import UIKit
import Foundation
class MyOrderViewController: UIViewController {
    @IBOutlet weak var myOrderTableView: UITableView!
    var myOrderList : MyOrderList?
    var viewModel = MyOrderViewModel()
    static let MyOrderListTableViewCellIdentifier = "MyOrderListTableViewCell"
    static let OrderDetailsViewControllerIdentifier = "OrderDetailsViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.show()
        configuration()
        registerXIBWithTableView()
        initializeTableView()
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "My Orders")
    }
    func registerXIBWithTableView(){
        let uinib = UINib(nibName: MyOrderViewController.MyOrderListTableViewCellIdentifier, bundle: nil)
        myOrderTableView.register(uinib, forCellReuseIdentifier: MyOrderViewController.MyOrderListTableViewCellIdentifier)
        
    }
    func initializeTableView(){
        myOrderTableView.delegate = self
        myOrderTableView.dataSource = self
    }
}
extension MyOrderViewController{
    func configuration(){
        initViewModel()
        observeEvent()
    }
    func initViewModel(){
        viewModel.fetchOrder()
    }
    func observeEvent(){
        viewModel.eventHandler = { Response in
            switch Response{
            case .Loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .DataLoaded:
                self.myOrderList = self.viewModel.myOrderList
                DispatchQueue.main.async {
                    self.myOrderTableView.reloadData()
                    Loader.shared.hide()
                }
            case .error(let error):
                print(error!)
                Loader.shared.hide()
            }
        }
    }
}
extension MyOrderViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.myOrderList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let MyOrderListTableViewCell = self.myOrderTableView.dequeueReusableCell(withIdentifier: MyOrderViewController.MyOrderListTableViewCellIdentifier, for: indexPath) as! MyOrderListTableViewCell
        
        MyOrderListTableViewCell.orderIDLabel.text = "Order ID : \(myOrderList?.data[indexPath.row].id ?? 0)"
        MyOrderListTableViewCell.orderDataLabel.text = "Ordererd date : \(myOrderList?.data[indexPath.row].created ?? "")"
        MyOrderListTableViewCell.orderPriceLabel.text = "₹\(myOrderList?.data[indexPath.row].cost ?? 0)"
        MyOrderListTableViewCell.selectionStyle = .none
        return MyOrderListTableViewCell
    }
}
extension MyOrderViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let OrderDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: MyOrderViewController.OrderDetailsViewControllerIdentifier) as! OrderDetailsViewController
        OrderDetailsViewController.orderId = myOrderList?.data[indexPath.row].id
        myOrderTableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(OrderDetailsViewController, animated: true)
        
    }

}
