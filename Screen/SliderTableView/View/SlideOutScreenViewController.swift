//
//  SlideOutScreenViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 26/06/24.
//

import UIKit

class SlideOutScreenViewController: UIViewController {
    private let slideTableViewCellidentifier = "SlideTableViewCell"
    private let myCartsTableViewCellIdentifier = "MyCartsTableViewCell"
    private let slideTableViewCellIdentifier = "SlideTableViewCell"
    private let productListningViewControllerIdentifier =  "ProductListningViewController"
    private let myCartViewControllerIdentifier = "MyCartViewController"
    private let myAccountViewControllerIdentifier = "MyAccountViewController"
    private let storeLocatorViewControllerIdentifer = "StoreLocatorViewController"
    private let myOrderViewControllerIdentifier = "MyOrderViewController"
    var getUserData1 : GetUserData1?
    var myCartData: MyCart?
    var count : Int?
    var viewModel = MyCartViewModel()
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailIdLabel: UILabel!
    @IBOutlet weak var profilePictureImage: UIImageView!{
        didSet{
            profilePictureImage.layer.cornerRadius = 52
            profilePictureImage.clipsToBounds = true
            profilePictureImage.layer.borderWidth = 2
            profilePictureImage.layer.borderColor = UIColor.white.cgColor
        }
    }
    var sliderIconArray = [UIImage(named: "myCart_icon"),
                           UIImage(named: "tables_icon"),
                           UIImage(named: "sofa"),
                           UIImage(named: "chair"),
                           UIImage(named: "cupboard"),
                           UIImage(named: "username_icon"),
                           UIImage(systemName: "mappin.and.ellipse"),
                           UIImage(named: "notepad-30"),
                           UIImage(named: "icons8-logout-30")]
    var sliderLabelArray = ["My Carts", "Tables" , "Sofas" , "Chairs" , "Cubboards" , "My Account" , "Store Locator" , "My Orders" , "Logout"]
    
    @IBOutlet weak var sliderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        getData()
        observeEvent()
        NotificationCenter.default.addObserver(self, selector: #selector(addTotalCount(notification:)), name: .totalCount, object: nil)
        initializeTableView()
        registerXIBwithTableView()
    }
   
    @objc func addTotalCount(notification : Notification){
        viewModel.fetchData()
    }
    deinit  {
        NotificationCenter.default.removeObserver(self)
    }
    func observeEvent(){
        viewModel.eventHandler = {
            Respons in
            switch Respons{
            case .loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .Dataloaded:
                self.myCartData = self.viewModel.myCart
                DispatchQueue.main.async {
                    self.sliderTableView.reloadData()
                }
            case .Error(let error):
                print(error)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImageFromUserDefaults()
    }
    func registerXIBwithTableView(){
        let uinib = UINib(nibName: slideTableViewCellidentifier, bundle: nil)
        sliderTableView.register(uinib, forCellReuseIdentifier: slideTableViewCellidentifier)

        let uiNib = UINib(nibName: myCartsTableViewCellIdentifier, bundle: nil)
        sliderTableView.register(uiNib, forCellReuseIdentifier: myCartsTableViewCellIdentifier)
    }
    func initializeTableView(){
        sliderTableView.dataSource = self
        sliderTableView.delegate = self
    }
    func getImageDataFromUserDefaults() -> Foundation.Data? {
        return UserDefaults.standard.data(forKey: "profile_pic")
    }
    func setImageFromUserDefaults() {
        if let imageData = getImageDataFromUserDefaults() {
            profilePictureImage.image = UIImage(data: imageData)
        } else {
            print("No image data found in UserDefaults")
        }
    }
    func getData(){
        if let userUrl = URL(string: Constant.Api.myAccountUrl){
            var urlRequest = URLRequest(url: userUrl)
            urlRequest.httpMethod = "GET"
            let accessToken = UserDefaults.standard.string(forKey: "access_token")
            urlRequest.setValue(accessToken, forHTTPHeaderField: "access_token")
            let urlSession = URLSession(configuration: .default)
            urlSession.dataTask(with: urlRequest) {  data, response, error in
                do{
                    self.getUserData1 = try JSONDecoder().decode(GetUserData1.self, from: data!)
                    print(self.getUserData1)
                }catch let error{
                    print(error)
                }
                DispatchQueue.main.async { [self] in
                    self.userNameLabel.text = (getUserData1?.data.user_data.first_name ?? "") + (getUserData1?.data.user_data.last_name ?? "")
                    self.userEmailIdLabel.text = getUserData1?.data.user_data.email
                }
            }
            .resume()
        }
    }
}
extension SlideOutScreenViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sliderIconArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = self.sliderTableView.dequeueReusableCell(withIdentifier: myCartsTableViewCellIdentifier) as! MyCartsTableViewCell
                cell.cartItemCount.text = "\(self.myCartData?.data.count ?? 0)"
            return cell
        }else{
            let cell = self.sliderTableView.dequeueReusableCell(withIdentifier: slideTableViewCellIdentifier, for: indexPath) as! SlideTableViewCell
            cell.sliderImageIconView.image = sliderIconArray[indexPath.row]
            cell.sliderIconLabel.text = sliderLabelArray[indexPath.row]
            return cell
        }
    }
}
extension SlideOutScreenViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            let MyCartViewController = self.storyboard?.instantiateViewController(withIdentifier: myCartViewControllerIdentifier) as! MyCartViewController
            navigationController?.pushViewController(MyCartViewController, animated: true)
            break
        case 1 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Table")
            ProductListningViewController.productcategoryid = "1"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
            break
        case 2 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Sofa")
            ProductListningViewController.productcategoryid = "3"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
            break
        case 3 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Chairs")
            ProductListningViewController.productcategoryid = "2"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
            break
        case 4 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Cupboards")
            ProductListningViewController.productcategoryid = "4"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
        case 5 :
            let MyAccountViewController = self.storyboard?.instantiateViewController(withIdentifier: myAccountViewControllerIdentifier) as! MyAccountViewController
            navigationController?.pushViewController(MyAccountViewController, animated: true)
            break
            
        case 6 :
            let StoreLocatorViewController = self.storyboard?.instantiateViewController(withIdentifier: storeLocatorViewControllerIdentifer) as! StoreLocatorViewController
            navigationController?.pushViewController(StoreLocatorViewController, animated: true)
            break
            
        case 7 :
            let MyOrderViewController = self.storyboard?.instantiateViewController(withIdentifier: myOrderViewControllerIdentifier) as! MyOrderViewController
            navigationController?.pushViewController(MyOrderViewController, animated: true)
            
        case 8 :
            showAlert(title: "Logout", message: "Are you sure you want to logout",okTitle: "Okay",cancelTitle: "Cancle", okHandler: {
                UserDefaults.standard.set(false, forKey: "is_login")
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.switchToLoginViewController()
                }
            })
        default :
            break
        }
    }
}
extension Notification.Name{
    static let totalCount = Notification.Name("Total Count")
}
