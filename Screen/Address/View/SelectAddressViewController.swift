//
//  SelectAddressViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 06/07/24.
//

import UIKit

class SelectAddressViewController: UIViewController {
    @IBOutlet weak var addressTableView: UITableView!
    private let addressTableViewCellIdentifier = "AddressTableViewCell"
    var addressArraty = [AddressEntity]()
    var combinedText : String?
    var selectedIndexAddress : String?
    var isSeleted : Bool = false
    var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXIBWithTableView()
        initializeTableView()
        setupNavigationBarr(for: self, withTitle: "Address List")
    }
    @IBOutlet weak var placeorder: UIButton!{
        didSet{
            placeorder.layer.cornerRadius = 10
            placeorder.clipsToBounds = true
        }
    }
    
    @IBAction func placeOrderBtn(_ sender: Any) {
        guard let selectedIndexAddress = selectedIndexAddress else {
                print("No address selected")
                return
        }
        showAlert(title: "Place Order", message: "Are you sure",okTitle: "Cancel",cancelTitle: "Place Order", cancelHandler:  {
            let selectedAddress = self.addressArraty[Int(self.selectedIndexAddress!) ?? 0]
            let combinedText = "\(selectedAddress.city ?? ""), \(selectedAddress.state ?? ""), \(selectedAddress.contry ?? ""), \(selectedAddress.zipCode ?? "")"
            let parameter : [String : String] = ["address" : combinedText]
            ApiHelpers.postURL(url: Constant.Api.orderApi, param: parameter, headers: .URLEncoded, module: OrderApiResponse.self) { result in
                print(result)
                showSuccessAlert()
            } Failuer: { error in
                print(error?.localizedDescription)
                showFailureAlert()
            }
        })
        
        func showSuccessAlert(){
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Success", message: "Order Placess Successfully", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .default)
                alert.addAction(okayAction)
                self.present(alert, animated: true)
            }
        }
        func showFailureAlert(){
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Failure", message: "Failed to place order", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .default)
                alert.addAction(okayAction)
                self.present(alert, animated: true)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addressArraty = DataBaseHelper.sharedInstance.getAllAddressDetails()
        addressTableView.reloadData()
    }
    func registerXIBWithTableView(){
        let uinib = UINib(nibName: addressTableViewCellIdentifier, bundle: nil)
        addressTableView.register(uinib, forCellReuseIdentifier: addressTableViewCellIdentifier)
    }
    func initializeTableView(){
        addressTableView.delegate = self
        addressTableView.dataSource = self
    }
}
extension SelectAddressViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.combinedText = "\(addressArraty[indexPath.row].city ?? ""), \(addressArraty[indexPath.row].state ?? ""), \(addressArraty[indexPath.row].contry ?? ""), \(addressArraty[indexPath.row].zipCode ?? "")"

        selectedIndex = indexPath.row
        addressTableView.reloadData()
    }
    
}
extension SelectAddressViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressArraty.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addressTableView.dequeueReusableCell(withIdentifier: addressTableViewCellIdentifier, for: indexPath) as! AddressTableViewCell
        let addressEntity = addressArraty[indexPath.row]
        let combinedText = "\(addressEntity.city ?? ""), \(addressEntity.state ?? ""), \(addressEntity.contry ?? ""), \(addressEntity.zipCode ?? "")"
                cell.addressLabel.text = combinedText
        
        let getUserName = UserDefaults.standard.string(forKey: "name")
        cell.deleteAddress = {
            DataBaseHelper.sharedInstance.deleteAddressData(index: indexPath.row, CompletionHandler: { value in
                self.addressArraty = value
                self.addressTableView.reloadData()
            })
        }
        cell.userNamelabel.text = getUserName
        DispatchQueue.main.async {
            self.addressTableView.reloadData()
        }
        
        cell.radioBtn.setImage(UIImage(named: indexPath.row == selectedIndex ? "check_radio-button-30" : "uncheck_radio-button-30"), for: .normal)
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            DataBaseHelper.sharedInstance.deleteAddressData(index: indexPath.row, CompletionHandler: { value in
                self.addressArraty = value
                self.addressTableView.reloadData()
            })
            self.addressTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
}
extension SelectAddressViewController{
        func setupNavigationBarr(for viewController: UIViewController, withTitle title: String) {
        viewController.navigationController?.navigationBar.backgroundColor = .red
        viewController.navigationController?.navigationBar.barTintColor = .red
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        viewController.navigationItem.titleView = titleLabel
    
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(viewController, action: #selector(backButtonTap), for: .touchUpInside)
        backButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "plus"), for: .normal)
        searchButton.addTarget(viewController, action: #selector(searchButtonTap), for: .touchUpInside)
        searchButton.tintColor = .white
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
    @objc func backButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func searchButtonTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

