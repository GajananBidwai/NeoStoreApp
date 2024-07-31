//
//  ResetPasswordViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 29/06/24.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    private let homeScreenViewControllerIdentifier = "HomeScreenViewController"
    var viewModel = ResetPasswordViewModel()
    
    @IBOutlet weak var currentPasswordTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "icons8-lock-30"), placeHolder: "Current Password", textFiled: currentPasswordTextField)
        }
    }
    @IBOutlet weak var newPasswordTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "icons8-lock-30"), placeHolder: "New Password", textFiled: newPasswordTextField)
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "icons8-lock-30"), placeHolder: "Confirm Password", textFiled: confirmPasswordTextField)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "Reset Password")
    }
    @IBAction func restPasswordBtn(_ sender: UIButton) {

        guard let currentPassword = currentPasswordTextField.text, !currentPassword.isEmpty else {
            showAlert(title: "Invalid Password", message: "Please enter a valid Password")
            return
        }
        
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty else{
            showAlert(title: "Invalid Passowrd", message: "Please enter a valid new passwors")
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else{
            showAlert(title: "Invalid Password", message: "Please enter a valid confirm password")
            return
        }
        
        if newPassword == confirmPassword{
            print("Password Matches")
        }else{
            showAlert(title: "Invalid Passoword", message: "Password does not matches")
        }
        let parameters : [String : String] = ["old_password" : currentPassword,
                                           "password" : newPassword,
                                           "confirm_password" : confirmPassword]
        Loader.shared.show()
        configuration()
        viewModel.fetchData(parameters: parameters)
    }

    @IBOutlet weak var submitBtn: UIButton!{
        didSet{
            submitBtn.layer.cornerRadius = 5
            submitBtn.clipsToBounds = true
        }
    }
}
extension ResetPasswordViewController{
    func configuration(){
        observeEvent()
    }
    func observeEvent(){
        viewModel.eventHandler = { [weak self] Result in
            guard let self = self else{ return}
            switch Result{
            case .Laading:
                Loader.shared.show()
                print("Start Loading")
            case .StopLoading:
                Loader.shared.hide()
                print("StopLoading")
            case .DataLoaded:
                Loader.shared.hide()
                self.showSuccesAlert()
            case .Error(_):
                Loader.shared.hide()
                self.showFailureAlert()
            }
        }
    }
}
extension ResetPasswordViewController{
    func showSuccesAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Password updated successfully", preferredStyle: .alert)
            let okayBtn = UIAlertAction(title: "Okay", style: .default) { _ in
                let HomeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                self.navigationController?.pushViewController(HomeScreenViewController, animated: true)
            }
            alert.addAction(okayBtn)
            self.present(alert, animated: true)
        }
    }
    func showFailureAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Failure", message: "Enter Valid Old Password", preferredStyle: .alert)
            let okayBtn = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okayBtn)
            self.present(alert, animated: true)
            Loader.shared.hide()
        }
    }
}
