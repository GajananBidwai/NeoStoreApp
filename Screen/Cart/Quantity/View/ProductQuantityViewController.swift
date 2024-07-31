//
//  ProductQuantityViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 03/07/24.
//

import UIKit
import Kingfisher

class ProductQuantityViewController: UIViewController {
    var productId : Int?
    var viewModel = ProductQuantityViewModel()
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!{
        didSet{
            productImageLabel.layer.borderWidth = 1
            productImageLabel.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var quantityTextField: UITextField!{
        didSet{
            quantityTextField.layer.borderWidth = 1
            quantityTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    @IBOutlet weak var submitbtn: UIButton!{
        didSet{
            submitbtn.layer.cornerRadius = 8
            submitbtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var detailsView: UIView!{
        didSet{
            detailsView.layer.cornerRadius = 15
            detailsView.clipsToBounds = true
        }
    }
    var name : String?
    var productImage : String?
    var tableData : [Data] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityTextField.delegate = self
        quantityTextField.setUpIntegerInput(maxDigits: 1)
        productNameLabel.text = name
        let image = productImage
        let imageUrl = URL(string: image!)
        productImageLabel.kf.setImage(with: imageUrl)
        setUpTapGestureRecognizer()
    }
    private func setUpTapGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    @objc func handleBackgroundTap(_ sender : UITapGestureRecognizer){
        let locate = sender.location(in: view)
        if !detailsView.frame.contains(locate) {
                    dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func submitBtnClick(_ sender: UIButton) {
        guard let quantity = quantityTextField.text else {return}
        let parameters : [String : String] = ["quantity" : "\(quantity)",
                                              "product_id": "\(productId ?? 1)"]
        viewModel.fetchQuantity(parameters: parameters)
        configuration()
    }
}
extension ProductQuantityViewController{
    func configuration(){
        observeEvent()
    }
    func observeEvent(){
        viewModel.eventHander = { Response in
            switch Response{
            case .Loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .DataLoaded:
                self.showSucessAlert()
            case .Error(let error):
                self.showFailureAlert()
            }
        }
    }
    func showSucessAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Added to cart", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
                NotificationCenter.default.post(name: .totalCount, object: nil)
                self.dismiss(animated: true)
            }
            alert.addAction(okayAction)
            self.present(alert, animated: true)
        }
    }
    func showFailureAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Failure", message: "Failed to add", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okayAction)
            self.present(alert, animated: true)
        }
    }
}
extension ProductQuantityViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == quantityTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

