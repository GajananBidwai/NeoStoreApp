//
//  MyCartViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 04/07/24.
//

import UIKit
import Kingfisher
class MyCartViewController: UIViewController {
    var myCart : MyCart?
    var editCart : EditCart?
    var productObject : product?
    var dataOject : [product] = []
    var productId : String?
    var toatalCount : Int?
    var viewModel = MyCartViewModel()
    var editViewModel = EditCartViewModel()
    @IBOutlet weak var myCartTableView: UITableView!
    @IBOutlet weak var mycartbtn: UIButton!{
        didSet{
            mycartbtn.layer.cornerRadius = 5
            mycartbtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var totalPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "My Cart")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        configuration()
        registerXIBWithTabelView()
        initializeTableView()
    }
    func configuration(){
        initViewModel()
        eventHandler()
    }
    func initViewModel(){
        viewModel.fetchData()
    }
    func eventHandler(){
        viewModel.eventHandler = {
            Response in
            switch Response{
            case .loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .Dataloaded:
                self.editCart = self.editCart
                self.myCart = self.viewModel.myCart
                DispatchQueue.main.async {
                    self.myCartTableView.reloadData()
                }
                self.updateCartPrice()
            case .Error(_):
                Loader.shared.hide()
            }
        }
        
        editViewModel.eventHandler = {
            Response in
            switch Response{
            case .loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .Dataloaded:
                self.updateCartPrice()
            case .Error(_):
                Loader.shared.hide()
            }
        }
    }
    func registerXIBWithTabelView(){
        let uinib = UINib(nibName: "MyCartTableViewCell", bundle: nil)
        myCartTableView.register(uinib, forCellReuseIdentifier: "MyCartTableViewCell")
    }
    func initializeTableView(){
        myCartTableView.delegate = self
        myCartTableView.dataSource = self
    }
    @IBAction func orderNowbtn(_ sender: UIButton) {
        let AddressViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
        navigationController?.pushViewController(AddressViewController, animated: true)
    }
}
extension MyCartViewController{
    func deleteData(productId: String, indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        let parameter: [String: String] = ["product_id": productId]
        ApiHelpers.postURL(url: Constant.Api.deletingUrl, param: parameter, headers: .URLEncoded, module: DeleteCarts.self) { Response in
            print(Response)
            NotificationCenter.default.post(name: .totalCount, object: nil)
            self.updateCartPrice()
            self.initViewModel()
            completion(true)
        } Failuer: { error in
            completion(false)
        }
    }
}
extension MyCartViewController : UITableViewDataSource, UITableViewDelegate, updatePriceProtocol{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCart?.data.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let MyCartTableViewCell = self.myCartTableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath) as! MyCartTableViewCell
        MyCartTableViewCell.productNameLabel.text = myCart?.data[indexPath.row].product.name
        MyCartTableViewCell.productCategoryLabel.text = "(\(myCart?.data[indexPath.row].product.product_category ?? ""))"
        let image = myCart?.data[indexPath.row].product.product_images
        if image != nil{
            let imageUrl = URL(string: image!)
            MyCartTableViewCell.productImageLabel.kf.setImage(with: imageUrl)
        }
        MyCartTableViewCell.priceLabel.text = "₹\(myCart?.data[indexPath.row].product.cost ?? 0)"
        MyCartTableViewCell.id = myCart?.data[indexPath.row].product_id
        if let price = viewModel.getPrice(for: indexPath.row) {
            MyCartTableViewCell.configure(with: price)
            MyCartTableViewCell.numberTextField.text = "\(String(describing: myCart?.data[indexPath.row].quantity))"
        }
        MyCartTableViewCell.delegateProperty = self
        MyCartTableViewCell.numberTextField.text = "\(myCart!.data[indexPath.row].quantity)"
        MyCartTableViewCell.selectionStyle = .none
        return MyCartTableViewCell
    }
    func pricePassToViewController(productId: Int, quantity: Int) {
        editViewModel.updateCart(paramters: ["product_id" : "\(productId)",
                                             "quantity" : "\(quantity)"])
        //self.updateCartPrice()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: { (action, view, completionHandler) in
            guard let productId = self.myCart?.data[indexPath.row].product_id else {
                completionHandler(false)
                return
            }
            self.deleteData(productId: "\(productId)", indexPath: indexPath) { success in
                if success {
                    DispatchQueue.main.async {
                        self.myCart?.data.remove(at: indexPath.row)
                        self.myCartTableView.deleteRows(at: [indexPath], with: .automatic)
                        self.myCartTableView.reloadData()
                        completionHandler(true)
                    }
                    if self.myCart?.data.isEmpty ?? true {
                        self.showAlert()
                    }
                } else {
                    completionHandler(false)
                }
            }
        })
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = .white
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    func showAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Cart", message: "Your Cart is Empty", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
                let HomeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                self.navigationController?.pushViewController(HomeScreenViewController, animated: true)
            }
            alert.addAction(okayAction)
            self.present(alert, animated: true)
        }
    }
}
extension MyCartViewController{
    func updateCartPrice(){
        let totalPrice = self.myCart?.data.reduce(0, { $0 + ($1.product.cost * $1.quantity) })
        DispatchQueue.main.async {
            self.totalPriceLabel.text =  "₹\(String(totalPrice ?? 0))"
        }
    }
}

