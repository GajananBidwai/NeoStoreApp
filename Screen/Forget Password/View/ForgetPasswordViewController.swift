//
//  ForgetPasswordViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 28/06/24.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    var viewModel = ForgotPasswordViewModel()
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "email_icon"), placeHolder: "Email", textFiled: emailTextField)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "Forgot Password")
    
    }
    @IBAction func btnContinue(_ sender: UIButton) {
        confuguration()
    }
}
extension ForgetPasswordViewController {
    func confuguration(){
        initViewModel()
        eventHandler()
    }
    func initViewModel(){
        guard let email = emailTextField.text else{return}
        let parameter : [String : String] = ["email" : email]
        viewModel.fetchForgotUrl(paramters: parameter)
    }
    func eventHandler(){
        viewModel.eventHandler = { Response in
            switch Response{
            case .Loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .DataLoaded:
                self.showSuccessAlert()
            case .Error:
                self.showFailedAlert()
            }
        }
    }
    func showSuccessAlert(){
        DispatchQueue.main.async {
            self.showAlert(title: "Success", message: "New password sent on email",okTitle: "Okay",okHandler: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    func showFailedAlert(){
        DispatchQueue.main.async {
            self.showAlert(title: "Failed", message: "Email is not Registered",okTitle: "Okay",cancelTitle: "Cancel")
        }
    }
}
