//
//  RegisterScreenViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 26/06/24.
//

import UIKit

class RegisterScreenViewController: UIViewController {
    var gender = ""
    var viewModel = RegisterViewModel()
    @IBOutlet weak var registerBtn: UIButton!{
        didSet{
            registerBtn.layer.cornerRadius = 10
            registerBtn.clipsToBounds = true
        }
    }
    @IBOutlet weak var btnMale: UIButton!{
        didSet{
            btnMale.setImage(UIImage(imageLiteralResourceName: "ChackedRadioButton"), for: .selected)
            btnMale.setImage(UIImage(imageLiteralResourceName: "UnchackedRadioButton"), for: .normal)
        }
    }
    @IBOutlet weak var btnFemale: UIButton!{
        didSet{
            btnFemale.setImage(UIImage(imageLiteralResourceName: "ChackedRadioButton"), for: .selected)
            btnFemale.setImage(UIImage(imageLiteralResourceName: "UnchackedRadioButton"), for: .normal)
        }
    }
    @IBOutlet weak var btncheckOutlet: UIButton!{
        didSet{
            btncheckOutlet.setImage(UIImage(imageLiteralResourceName: "checked_icon"), for: .selected)
            btncheckOutlet.setImage(UIImage(imageLiteralResourceName: "uncheck_icon"), for: .normal)
        }
    }
    @IBOutlet weak var firstNametextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "username_icon"), placeHolder: "First Name", textFiled: firstNametextField)
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "username_icon"), placeHolder: "Last Name", textFiled: lastNameTextField)
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "email_icon"), placeHolder: "Email", textFiled: emailTextField)
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "icons-lock"), placeHolder: "Password", textFiled: passwordTextField)
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "icons-lock"), placeHolder: "Confirm Password", textFiled: confirmPasswordTextField)
        }
    }
    @IBOutlet weak var phoneNumbeTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "icons8-iphone40"), placeHolder: "Phone Number", textFiled: phoneNumbeTextField)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "Register")
    }
    
    @IBAction func checkbtn(_ sender: UIButton) {
        btncheckOutlet.isSelected.toggle()
    }
    @IBAction func registerBtn(_ sender: Any) {
        registerUser()
    }
    @IBAction func btnSelectGender(_ sender: UIButton) {
        if sender == btnMale{
            gender = "M"
            btnMale.isSelected = true
            btnFemale.isSelected = false
        }else{
            gender = "F"
            btnMale.isSelected = false
            btnFemale.isSelected = true
        }
    }
}
extension RegisterScreenViewController{
    func registerUser(){
        guard let firstName = firstNametextField.text else {return}
        guard let lastName = lastNameTextField.text else{ return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let confirmPassword = confirmPasswordTextField.text else {return}
        guard let phoneNo = phoneNumbeTextField.text else {return}
        let  parameter : [String : String] = ["first_name" : firstName,
                                               "last_name" : lastName,
                                               "email" : email,
                                               "password" : password,
                                               "confirm_password" : confirmPassword,
                                               "gender" : gender,
                                               "phone_no" : phoneNo]
        configuration()
        viewModel.fetchData(parameters: parameter)
    }
    func configuration(){
        observeEvent()
    }
    func observeEvent(){
        viewModel.eventHandler = { Result in
            switch Result{
            case .Loading :
                Loader.shared.show()
            case .Stoploading :
                Loader.shared.hide()
            case .DataLoadeded:
                self.showSuccessAction()
            case .error(_):
                self.showFailedAlert()
            }
        }
    }
    func showSuccessAction(){
        DispatchQueue.main.async {
            self.showAlert(title: "Success", message: "Registration successful")
        }
    }
    func showFailedAlert(){
        DispatchQueue.main.async {
            self.showAlert(title: "Failure", message: "Registration is unsuccessful. Email id already exist")
        }
    }
}
