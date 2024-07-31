//
//  MyCartTableViewCell.swift
//  NeoStoreApp
//
//  Created by Neosoft on 04/07/24.
//

import UIKit
protocol updatePriceProtocol{
    func pricePassToViewController(productId : Int, quantity : Int)
}

class MyCartTableViewCell: UITableViewCell {

    var numberArray = ["1","2","3","4","5","6","7"]
    var pickerView : UIPickerView?
    var pickerToolbar: UIToolbar?
    var basePrice : Int = 0
    var id : Int?
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    var delegateProperty : updatePriceProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPickerView()
        numberTextField.text = "1"
    }
    func setupPickerView() {
        pickerView = UIPickerView()
        pickerView?.delegate = self
        pickerView?.dataSource = self
        pickerToolbar = UIToolbar()
        pickerToolbar?.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTap(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerToolbar?.setItems([flexibleSpace, doneButton], animated: false)
        numberTextField.inputView = pickerView
        numberTextField.inputAccessoryView = pickerToolbar
        
    }
    
    @IBAction func dropDownBtn(_ sender: Any) {
        numberTextField.becomeFirstResponder()
    }
    @objc func doneButtonTap(_ sender: UIBarButtonItem) {
        let selectedRow = pickerView?.selectedRow(inComponent: 0)
        numberTextField.text = numberArray[selectedRow ?? 0]
        updatePriceLabel()
        
        self.endEditing(true)
    }
    func configure(with price: Int) {
        self.basePrice = price
        updatePriceLabel()
    }
    
    func updatePriceLabel() {
        guard let selectedText = numberTextField.text, let selectedNumber = Int(selectedText) else { return }
        let totalPrice = basePrice * selectedNumber
        priceLabel.text = String(format: "₹%.2f", Double(totalPrice))
        guard let delegateProperty = delegateProperty else{
            return
        }
        delegateProperty.pricePassToViewController(productId: id ?? 0, quantity: selectedNumber)
    
    }
}
extension MyCartTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberArray[row]
    }
}
