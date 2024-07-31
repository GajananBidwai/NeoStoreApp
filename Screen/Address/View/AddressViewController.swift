//
//  AddressViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 05/07/24.
//

import UIKit
import CoreData
class AddressViewController: UIViewController {

    private let selectAddressViewControllerIdentifier = "SelectAddressViewController"
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityTextFiedl: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipCodetextField: UITextField!
    
    @IBOutlet weak var addressBtn: UIButton!{
        didSet{
            addressBtn.layer.cornerRadius = 10
            addressBtn.clipsToBounds = true
        }
    }
    var addressArray = [AddressEntity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        zipCodetextField.delegate = self
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "Add Address")
    }
    @IBAction func saveAddress(_ sender: UIButton) {
        saveData()
        let addressArray = DataBaseHelper.sharedInstance.getAllAddressDetails()
        if let addressEntity = addressArray.last {
            let combinedText = "\(addressEntity.city ?? ""), \(addressEntity.state ?? ""), \(addressEntity.contry ?? ""), \(addressEntity.zipCode ?? "")"
            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: selectAddressViewControllerIdentifier) as! SelectAddressViewController
            secondVC.selectedIndexAddress = combinedText
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}
extension AddressViewController {
    func saveData(){
        guard let city = cityTextFiedl.text, !city.isEmpty else {
            showAlert(title: "Failure", message: "City Field is empty")
            return
        }
        guard let state = stateTextField.text, !state.isEmpty else {
            showAlert(title: "Failure", message: "State Field is emoty")
            return
        }
        guard let country = countryTextField.text, !country.isEmpty else {
            showAlert(title: "Failure", message: "Country Field is empty")
            return
        }
        guard let zipCode = zipCodetextField.text, !zipCode.isEmpty else {
            showAlert(title: "Failure", message: "Zipcode Field is emo")
            return
        }
        let paramters = ["city": city,
                         "state" : state,
                         "contry" : country,
                         "zipCode": zipCode]
        
        DataBaseHelper.sharedInstance.saveDataToCoreData(addressEntity: paramters)
    }
}
extension AddressViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == zipCodetextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
}
