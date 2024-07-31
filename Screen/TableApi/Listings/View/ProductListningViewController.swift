//
//  TablesViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 01/07/24.
//

import UIKit
import Kingfisher


class ProductListningViewController: UIViewController {
   
    var table: Table?
    var productcategoryid : String?
    private var ViewModel = ProductListingsViewModel()
    static let ProductListingsTableViewCellIdentifier = "ProductListingsTableViewCell"
    static let ProductDetailsViewControllerIdentifier = "ProductDetailsViewController"
    @IBOutlet weak var productTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.show()
        configuration()
        registerXIBWithTableView()
        initializeTableView()
      
    }
    func registerXIBWithTableView(){
        let uinib = UINib(nibName: ProductListningViewController.ProductListingsTableViewCellIdentifier, bundle: nil)
        productTableView.register(uinib, forCellReuseIdentifier: ProductListningViewController.ProductListingsTableViewCellIdentifier)
    }
    func initializeTableView(){
        productTableView.dataSource = self
        productTableView.delegate = self
    }
}
extension ProductListningViewController{
    func configuration(){
        self.ViewModel.productcategoryid = self.productcategoryid
        initViewModel()
        observeEvent()
    }
    func initViewModel(){
        ViewModel.fetchProduct()
    }
    func observeEvent(){
        ViewModel.eventHandler = { [weak self] event in // object of the event may be nil of may not be nil
            guard let self = self else{return}
            switch event{
            case .loading:
              //  Loader.shared.show()
                print("Start Loading")
            case .stopLoading:
                print("Stop Loading")
            case .dataloaded:
                print(self.ViewModel.table)
                self.table = self.ViewModel.table
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                    Loader.shared.hide()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
extension ProductListningViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        table?.data.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TablesTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: ProductListningViewController.ProductListingsTableViewCellIdentifier, for: indexPath) as! ProductListingsTableViewCell
        TablesTableViewCell.productNameLabel.text = table?.data[indexPath.row].name
        TablesTableViewCell.productPrice.text = "Rs.\(table?.data[indexPath.row].cost ?? 0)"
        TablesTableViewCell.productProcerLabel.text = table?.data[indexPath.row].producer
        let image = table?.data[indexPath.row].product_images
        let imageUrl = URL(string: image!)
        TablesTableViewCell.productImageView.kf.setImage(with: imageUrl)
        return TablesTableViewCell
    }
}
extension ProductListningViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ProductDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: ProductListningViewController.ProductDetailsViewControllerIdentifier) as! ProductDetailsViewController
        ProductDetailsViewController.productId = String(table!.data[indexPath.row].id)
        navigationController?.pushViewController(ProductDetailsViewController, animated: true)
    }
}
