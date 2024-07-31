//
//  UITextField + Extension.swift
//  NeoStoreApp
//
//  Created by Neosoft on 26/06/24.
//

import Foundation
import UIKit
extension UITextField{
    func setTextFields(image : UIImage ,placeHolder : String, textFiled : UITextField){
        textFiled.setIcon(image)
        textFiled.attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        textFiled.layer.borderWidth = 1.5
        textFiled.layer.borderColor = UIColor.white.cgColor
    }
    func setIcon(_ image : UIImage){
        let iconView = UIImageView(frame: CGRect(x: 10, y: 3, width: 18, height: 22))
        iconView.image = image
        //  iconView.backgroundColor = .blue
        iconView.tintColor = .white
        let iconContainer : UIView = UIView(frame: CGRect(x: 20, y: 0, width: 45, height: 30))
        iconContainer.addSubview(iconView)
        //  iconContainer.backgroundColor = .white
        leftView = iconContainer
        leftViewMode = .always
        
    }
    func addPaddingToTheTextField() {
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        paddingView.backgroundColor = .green
    }
    
    func setUpIntegerInput(maxDigits: Int) {
        self.keyboardType = .numberPad
        self.addTarget(self, action: #selector(restrictInput), for: .editingChanged)
    }
    
    @objc private func restrictInput() {
        guard let text = self.text else { return }
        let filtered = text.filter { "1234567".contains($0) }
        if filtered != text {
            self.text = filtered
        }
        if text.count > 1 {
            self.text = String(text.prefix(1))
        }
    }
    
    func setUpMaxInput(maxDigits: Int) {
        self.keyboardType = .numberPad
        self.addTarget(self, action: #selector(restrictDigitInput), for: .editingChanged)
    }
    
    @objc private func restrictDigitInput() {
        guard let text = self.text else { return }
        let filtered = text.filter { "1234567890".contains($0) }
        if filtered != text {
            self.text = filtered
        }
        if text.count > 10 {
            self.text = String(text.prefix(10))
        }
    }
}
//extension UITextFieldDelegate {
//    func shouldAllowOnlyIntegers(textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
//        let allowedCharacters = CharacterSet.decimalDigits
//        let characterSet = CharacterSet(charactersIn: string)
//        return allowedCharacters.isSuperset(of: characterSet)
//    }
//}
