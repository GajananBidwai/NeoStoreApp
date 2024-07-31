//
//  LoginScreenViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 25/06/24.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    var login : Login?
    var viewModel = LoginViewModel()
    @IBOutlet weak var userNameTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "username_icon"), placeHolder: "Username", textFiled: userNameTextField)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "icons-lock"), placeHolder: "Password", textFiled: passwordTextField)
        }
    }
    @IBOutlet weak var btnLogin: UIButton!{
        didSet{
            btnLogin.layer.cornerRadius = 10
            btnLogin.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        guard let email = userNameTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        let parameters : [String : String] = ["email" :  email,
                                              "password" : password]
        Loader.shared.show()
        viewModel.login(parameters: parameters)
        configuration()
    }
    @IBAction func btnRegitser(_ sender: UIButton) {
        let RegisterScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterScreenViewController") as! RegisterScreenViewController
        navigationController?.pushViewController(RegisterScreenViewController, animated: true)
    }
    @IBAction func forgetPasswordBtn(_ sender: UIButton) {
        let ForgetPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        navigationController?.pushViewController(ForgetPasswordViewController, animated: true)
    }
}
extension LoginScreenViewController {
    func configuration(){
        observeEvent()
    }
    func observeEvent(){
        viewModel.eventHandler = { Event in
            switch Event{
            case .Loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .DataLoaded:
                Loader.shared.hide()
                self.navigateToHomeScreenVC()
            case .Error(let error):
                Loader.shared.hide()
                self.showLoginFailed()
            }
        }
    }
    func navigateToHomeScreenVC (){
        DispatchQueue.main.async {
            self.showAlert(title: "Success", message: "Logged in Successfully",okTitle: "Okay",cancelTitle: "Cancel", okHandler:  {
                let HomeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                    self.navigationController?.pushViewController(HomeScreenViewController, animated: true)
            })
        }
    }
    func showLoginFailed(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Invalid Credential", preferredStyle: .alert)
            let okayBtn = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okayBtn)
            self.present(alert, animated: true)
        }
    }
}
