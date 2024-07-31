//
//  UIViewController + Extension.swift
//  NeoStoreApp
//
//  Created by Neosoft on 23/07/24.
//

import Foundation
import UIKit
extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = "Okay", cancelTitle: String = "Cancel", okHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            okHandler?()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive) { _ in
            cancelHandler?()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    func setTextFields(image : UIImage ,placeHolder : String, textFiled : UITextField){
        textFiled.setIcon(image)
        textFiled.attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        textFiled.layer.borderWidth = 1.5
        textFiled.layer.borderColor = UIColor.white.cgColor
    }
    
}
