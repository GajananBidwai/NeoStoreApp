//
//  ProductDetailsViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 02/07/24.
//

import UIKit
import Kingfisher
class ProductDetailsViewController: UIViewController {
    var productDetails : ProductDetails?
    var productId : String?
    var dataclass : DataClass?
    var ViewModel = ProductDetailViewModel()
    static let productQuantityIdentifier = "ProductQuantityViewController"
    static let ratingControllerIdentifier = "RatingViewController"
    static let productDetailTableViewCellIdentifier = "ProductDetailsTableViewCell"
    static let productImageTableViewCellIdentifier = "ProductImagesTableViewCell"
    static let productDescriptionTableViewCellIdentifier = "ProductDescriptionTableViewCell"
    
    @IBOutlet weak var productDetailsTableView: UITableView!{
        didSet{
            productDetailsTableView.layer.cornerRadius = 10
            productDetailsTableView.clipsToBounds = true
        }
    }
    @IBOutlet weak var butBtn: UIButton!{
        didSet{
            butBtn.layer.cornerRadius = 5
            butBtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var rateBtn: UIButton!{
        didSet{
            rateBtn.layer.cornerRadius = 5
            rateBtn.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.show()
        configuration()
        registerXIBWithTableView()
        initializeTableView()
    }
    func configuration(){
        initViewModel()
        eventObserver()
    }
    func initViewModel(){
        ViewModel.fetchData(productId: ["product_id" : productId!])
    }
    func eventObserver(){
        ViewModel.eventHandler = { Response in
            switch Response{
            case .Loading:
                print("Start loading")
            case .StopLoading:
                print("Stop Loading")
            case .dataLoaded:
                self.productDetails = self.ViewModel.productDetails
                DispatchQueue.main.async {
                    NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: self.productDetails?.data.name ?? "")
                    self.productDetailsTableView.reloadData()
                    Loader.shared.hide()
                }
                print("Data Loaded")
            case .Error(let error):
                print(error)
                Loader.shared.hide()
            }
        }
    }
    
    @IBAction func buyNowBtn(_ sender: Any) {
        let ProductQuantityViewController = self.storyboard?.instantiateViewController(withIdentifier: ProductDetailsViewController.productQuantityIdentifier) as! ProductQuantityViewController
        ProductQuantityViewController.name = productDetails?.data.name
        ProductQuantityViewController.productImage = productDetails?.data.product_images[0].image ?? ""
        ProductQuantityViewController.productId = productDetails?.data.id
        ProductQuantityViewController.modalPresentationStyle = .overCurrentContext
        self.present(ProductQuantityViewController, animated: false)
    }
    @IBAction func rateNowBtn(_ sender: Any) {
        let RatingViewController = self.storyboard?.instantiateViewController(withIdentifier: ProductDetailsViewController.ratingControllerIdentifier) as! RatingViewController
        RatingViewController.productName = productDetails?.data.name
        RatingViewController.productImage = productDetails?.data.product_images[0].image ?? ""
        RatingViewController.productId = productDetails?.data.id
        RatingViewController.modalPresentationStyle = .overCurrentContext
        self.present(RatingViewController, animated: true)
    }
    
    func registerXIBWithTableView(){
        let uinib = UINib(nibName: ProductDetailsViewController.productDetailTableViewCellIdentifier, bundle: nil)
        productDetailsTableView.register(uinib, forCellReuseIdentifier: ProductDetailsViewController.productDetailTableViewCellIdentifier)
        
        let nib = UINib(nibName: ProductDetailsViewController.productImageTableViewCellIdentifier, bundle: nil)
        productDetailsTableView.register(nib, forCellReuseIdentifier: ProductDetailsViewController.productImageTableViewCellIdentifier)
        let descriptionNib = UINib(nibName: ProductDetailsViewController.productDescriptionTableViewCellIdentifier, bundle: nil)
        productDetailsTableView.register(descriptionNib, forCellReuseIdentifier: ProductDetailsViewController.productDescriptionTableViewCellIdentifier)
    }
    func initializeTableView(){
        productDetailsTableView.delegate = self
        productDetailsTableView.dataSource = self
        productDetailsTableView.reloadData()
    }
    
}
extension ProductDetailsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let ProductDetailsTableViewCell = self.productDetailsTableView.dequeueReusableCell(withIdentifier: ProductDetailsViewController.productDetailTableViewCellIdentifier, for: indexPath) as! ProductDetailsTableViewCell
            
            ProductDetailsTableViewCell.productNameLabel.text = productDetails?.data.name
            ProductDetailsTableViewCell.productProducerLabel.text = productDetails?.data.producer
            ProductDetailsTableViewCell.selectionStyle = .none
            return ProductDetailsTableViewCell
        }else if indexPath.section == 1 {
            let ProductImagesTableViewCell = self.productDetailsTableView.dequeueReusableCell(withIdentifier: ProductImagesTableViewCell.identifier, for: indexPath) as! ProductImagesTableViewCell
            ProductImagesTableViewCell.priceLabel.text = "Rs. \(String(productDetails?.data.cost ?? 0))"
            ProductImagesTableViewCell.productDetails = productDetails
            let image = productDetails?.data.product_images[indexPath.row].image
            if image != nil{
                let imageUrl = URL(string: image!)
                ProductImagesTableViewCell.productImageLabel.kf.setImage(with: imageUrl)
            }
            ProductImagesTableViewCell.selectionStyle = .none
            return ProductImagesTableViewCell
        }else{
            let ProductDescriptionTableViewCell = self.productDetailsTableView.dequeueReusableCell(withIdentifier: ProductDetailsViewController.productDescriptionTableViewCellIdentifier, for: indexPath) as! ProductDescriptionTableViewCell
            
            ProductDescriptionTableViewCell.descritpitionLabel.text = productDetails?.data.description
            ProductDescriptionTableViewCell.selectionStyle = .none
            return ProductDescriptionTableViewCell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
extension ProductDetailsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 100.0
        } else if indexPath.section == 1{
            return 300.0
        } else {
            return 260.0
        }
    }
}
