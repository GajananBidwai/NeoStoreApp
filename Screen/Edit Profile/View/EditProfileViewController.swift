//
//  EditProfileViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 29/06/24.
//

import UIKit
import Foundation
class EditProfileViewController: UIViewController {
    
    var getData : GetData?
    var datePicker2: UIDatePicker?
    var viewModel = EditViewModel()
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.layer.cornerRadius = 65
            profileImageView.clipsToBounds = true
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
    @IBOutlet weak var dobTextField: UITextField!{
        didSet{
            setTextFields(image: UIImage(imageLiteralResourceName: "dob_icon"), placeHolder: "Date Of Birth", textFiled: dobTextField)
        }
    }
    @IBOutlet weak var submitBtnOutlet: UIButton!{
        didSet{
            submitBtnOutlet.layer.cornerRadius = 5
            submitBtnOutlet.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
        implementCamera()
        setImageFromUserDefaults()
        dobDatePicker()
        NavigationBarConfigurator.setupNavigationBar(for: self, withTitle: "Edit Profile")
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        phoneNumberTextField.setUpMaxInput(maxDigits: 10)
        firstNameTextField.isUserInteractionEnabled = true
        firstNameTextField.isEnabled = true
        firstNameTextField.becomeFirstResponder()
        self.view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func dobDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped(_:)))
        let spaceBotton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceBotton, done], animated: true)
        datePicker2 = UIDatePicker()
        if let datepicker = datePicker2 {
            datepicker.datePickerMode = .date
            dobTextField.inputView = datepicker
            dobTextField.inputAccessoryView = toolbar
            toolbar.isTranslucent = true
            datepicker.preferredDatePickerStyle = .wheels
            datepicker.addTarget(self, action: #selector(dateSelected(_ :)), for: .valueChanged)
            dobTextField.addPaddingToTheTextField()
        }
    }
    @objc func dateDropdownButtonTapped(_ sender: UIButton) {
        dobTextField.becomeFirstResponder()
    }
    @objc func dateSelected(_ sender: UIDatePicker) {
        let currentDate = Date()
        sender.maximumDate = currentDate
        
    }
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        if let datePicker = datePicker2 {
            let dateFormmater = DateFormatter()
            dateFormmater.dateStyle = .full
            dateFormmater.dateFormat = "DD-MM-YYYY"
            dateFormmater.dateStyle = .long
            let date = dateFormmater.string(from: datePicker.date)
            dobTextField.text = date
            self.view.endEditing(true)
        }
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty, firstName.isValidName() else{
            showAlert(title: "Invalid Name", message: "Enter a valid First Name")
            return
        }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty, lastName.isValidName() else{
            showAlert(title: "Inavalid LastName", message: "Enter a Valid Last Name")
            return
        }
        guard let email = emailTextField.text, !email.isEmpty, email.isValidEmail() else{
            showAlert(title: "Inavalid Email", message: "Please enter an email address")
            return
        }
        guard let phoneNo = phoneNumberTextField.text, !phoneNo.isEmpty, phoneNo.isValidPhoneNumber() else{
            showAlert(title: "Invalid phone Number", message: "Please enter your phone number")
            return
        }
        guard let dob = dobTextField.text, !dob.isEmpty else{
            showAlert(title: "Invalid DOB", message: "Enter Your Date of Birth")
            return
        }        
        let parameters : [String : String] = ["first_name":firstName,
                                              "last_name": lastName,
                                              "email" : email,
                                              "dob" : dob,
                                              "phone_no" : phoneNo,
                                              "profile_pic" : ""]
        Loader.shared.show()
        viewModel.fetchData(parameters: parameters)
        configuration()
        
    }
}
extension EditProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func implementCamera(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPopUpForCameraAndGallery(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func openPopUpForCameraAndGallery(tapGestureRecognizer : UITapGestureRecognizer){
        let alert = UIAlertController(title: "Profile Picture", message: "Choose a Source", preferredStyle: .actionSheet)
        let openCameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.OpenCamera()
        }
        let openGalleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.openGallery()
        }
        let canleAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(openCameraAction)
        alert.addAction(openGalleryAction)
        alert.addAction(canleAction)
        self.present(alert, animated: true)
    }
    func OpenCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = true
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true)
        }else{
            let alert = UIAlertController(title: "Camera", message: "This device does not have camera", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okayAction)
            self.present(alert, animated: true)
        }
    }
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            pickerController.allowsEditing = true
            self.present(pickerController, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editingImage = info[.editedImage] as? UIImage{
            profileImageView.image = editingImage
            saveSelectedImageData()
        }else if let originalImege = info[.originalImage] as? UIImage{
            profileImageView.image = originalImege
            saveSelectedImageData()
        }
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    func saveImageDataToUserDefaults(imageData: Foundation.Data) {
        UserDefaults.standard.set(imageData, forKey: "profile_pic")
        UserDefaults.standard.synchronize()
    }
    func saveSelectedImageData() {
        if let image = profileImageView.image,
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
            profileImageView.image = UIImage(data: imageData)
        } else {
            print("No image data found in UserDefaults")
        }
    }
    func getUserDetails(){
        if let userUrl = URL(string: Constant.Api.myAccountUrl){
            var urlRequest = URLRequest(url: userUrl)
            urlRequest.httpMethod = "GET"
            let accessToken = UserDefaults.standard.string(forKey: "access_token")
            urlRequest.setValue(accessToken, forHTTPHeaderField: "access_token")
            let urlSession = URLSession(configuration: .default)
            urlSession.dataTask(with: urlRequest) {  data, response, error in
                do{
                    self.getData = try JSONDecoder().decode(GetData.self, from: data!)
                    print(self.getData)
                }catch let error{
                    print(error)
                }
                DispatchQueue.main.async { [self] in
                    self.firstNameTextField.text = getData?.data.user_data.first_name
                    self.lastNameTextField.text = getData?.data.user_data.last_name
                    self.emailTextField.text = getData?.data.user_data.email
                    self.phoneNumberTextField.text = getData?.data.user_data.phone_no
                    self.dobTextField.text = getData?.data.user_data.dob
                }
            }
            .resume()
        }
    }
    func configuration(){
        observeEvent()
    }
    func observeEvent(){
        viewModel.eventHandler = { Response in
            switch Response{
            case .Loading:
                print("Start Loading")
            case .StopLoading:
                print("Stop Loading")
            case .DataLoaded:
                Loader.shared.hide()
                self.showSuccessAlert()
            case .Error(_):
                Loader.shared.hide()
                self.showFailedAlert()
            }
        }
    }
    func showSuccessAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Account details updated successfully.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okayAction)
            self.present(alert, animated: true)
        }
    }
    func showFailedAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Failed", message: "Please enter all fields", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okayAction)
            self.present(alert, animated: true)
        }
    }
}
extension EditProfileViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == phoneNumberTextField {
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
            }
            return true
        }
}
