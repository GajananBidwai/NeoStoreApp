//
//  MyAccountViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 28/06/24.
//

import UIKit
import Kingfisher
class MyAccountViewController: UIViewController {
    
    var user : User?
    @IBOutlet weak var profilePictureImageLabel: UIImageView!{
        didSet{
            profilePictureImageLabel.layer.cornerRadius = 65
            profilePictureImageLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var firstNameTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "username_icon"), placeHolder: "First Name", textFiled: firstNameTextField)
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
    @IBOutlet weak var phoneNumberTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "iphoneIcon"), placeHolder: "Phone Number", textFiled: phoneNumberTextField)
        }
    }
    @IBOutlet weak var dateOfBirthTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "dob_icon"), placeHolder: "Date of Birth", textFiled: dateOfBirthTextField)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        self.title = "My Account"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImageFromUserDefaults()
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "My Account")
    }
    @IBOutlet weak var editBtn: UIButton!{
        didSet{
            editBtn.layer.cornerRadius = 5
            editBtn.clipsToBounds = true
        }
    }
    
    @IBAction func editButtonVC(_ sender: UIButton) {
        let EditProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.pushViewController(EditProfileViewController, animated: true)
    }
    @IBAction func resetPasswodButton(_ sender: UIButton) {
        let ResetPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        navigationController?.pushViewController(ResetPasswordViewController, animated: true)
    }
}
extension MyAccountViewController{
    func getData(){
        if let userUrl = URL(string: Constant.Api.myAccountUrl){
            
            var urlRequest = URLRequest(url: userUrl)
            urlRequest.httpMethod = "GET"
            
            let accessToken = UserDefaults.standard.string(forKey: "access_token")
            urlRequest.setValue(accessToken, forHTTPHeaderField: "access_token")
            
            let urlSession = URLSession(configuration: .default)
            
            urlSession.dataTask(with: urlRequest) {  data, response, error in
                do{
                    self.user = try JSONDecoder().decode(User.self, from: data!)
                    print(self.user)
                    
                    
                }catch let error{
                    print(error)
                }
                DispatchQueue.main.async { [self] in
                    self.firstNameTextField.text = user?.data.user_data.first_name
                    self.lastNameTextField.text = user?.data.user_data.last_name
                    self.emailTextField.text = user?.data.user_data.email
                    self.phoneNumberTextField.text = user?.data.user_data.phone_no
                    self.dateOfBirthTextField.text = user?.data.user_data.dob
                }
            }
            .resume()
        }
    }
    func saveImageDataToUserDefaults(imageData: Foundation.Data) {
        UserDefaults.standard.set(imageData, forKey: "profile_pic")
        UserDefaults.standard.synchronize()
    }
    
    func saveSelectedImageData() {
        if let image = profilePictureImageLabel.image,
           let imageData = image.jpegData(compressionQuality: 0.5) {
            saveImageDataToUserDefaults(imageData: imageData)
        } else {
            print("Image or Image Data is nil")
        }
    }
    
    func getImageDataFromUserDefaults() -> Foundation.Data? {
        return UserDefaults.standard.data(forKey: "profile_pic")
    }
    func setImageFromUserDefaults() {
        if let imageData = getImageDataFromUserDefaults() {
            profilePictureImageLabel.image = UIImage(data: imageData)
        } else {
            print("No image data found in UserDefaults")
        }
    }
}

