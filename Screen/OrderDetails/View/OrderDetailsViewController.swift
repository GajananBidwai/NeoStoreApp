//
//  OrderDetailsViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 08/07/24.
//

import UIKit
import Kingfisher
class OrderDetailsViewController: UIViewController {
    @IBOutlet weak var orderDetailsTableView: UITableView!
    @IBOutlet weak var totalPriceTable: UILabel!
    var orderId : Int?
    var orderDetails : OrderDetails?
    private let ViewModel = OrderDetailsViewModel()
    static let OrderDetailsTableViewCellIdentifier = "OrderDetailsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.show()
        configuration()
        registerXIBWithTableView()
        initializeTabelView()
    }
    func registerXIBWithTableView(){
        let uinib = UINib(nibName: OrderDetailsViewController.OrderDetailsTableViewCellIdentifier, bundle: nil)
        orderDetailsTableView.register(uinib, forCellReuseIdentifier: OrderDetailsViewController.OrderDetailsTableViewCellIdentifier)
    }
    func initializeTabelView(){
        orderDetailsTableView.delegate = self
        orderDetailsTableView.dataSource = self
    }
}
extension OrderDetailsViewController{
    func configuration(){
        self.ViewModel.orderId = self.orderId
        initViewModel()
        observeEvent()
    }
    func initViewModel(){
        ViewModel.fetchData()
    }
    func observeEvent(){
        ViewModel.eventHandler = {  Response in
            switch Response{
            case .Loading:
                print("Data Loading")
            case .StopLoading:
                print("Stop Loading")
            case .dataLoaded:
                self.orderDetails = self.ViewModel.orderDetails
                DispatchQueue.main.async {
                    let totalPrice = self.ViewModel.orderDetails?.data.order_details.reduce(0, { $0 + $1.total })
                    self.totalPriceTable.text = "₹\(totalPrice ?? 0)"
                    self.orderDetailsTableView.reloadData()
                    NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "Order ID : \(self.orderId ?? 0)")
                    Loader.shared.hide()
                }
            case .error(let error):
                Loader.shared.hide()
                print(error)
            }
        }
    }
}
extension OrderDetailsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewModel.orderDetails?.data.order_details.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let OrderDetailsTableViewCell = self.orderDetailsTableView.dequeueReusableCell(withIdentifier: OrderDetailsViewController.OrderDetailsTableViewCellIdentifier, for: indexPath) as! OrderDetailsTableViewCell
        OrderDetailsTableViewCell.productNameLabel.text = orderDetails?.data.order_details[indexPath.row].prod_name
        OrderDetailsTableViewCell.poructCategoryLabel.text = "(\(orderDetails?.data.order_details[indexPath.row].prod_cat_name ?? ""))"
        OrderDetailsTableViewCell.priceLabel.text = "₹\(String(orderDetails!.data.order_details[indexPath.row].total))"
        OrderDetailsTableViewCell.quantityLabel.text = "QTY : \(orderDetails!.data.order_details[indexPath.row].quantity)"
        let image = orderDetails?.data.order_details[indexPath.row].prod_image
        let imageUrl = URL(string: image!)
        OrderDetailsTableViewCell.productImageLabel.kf.setImage(with: imageUrl)
        OrderDetailsTableViewCell.selectionStyle = .none
        return OrderDetailsTableViewCell
    }
}
extension OrderDetailsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110.0
    }
}
