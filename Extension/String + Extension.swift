//
//  String + Extension.swift
//  NeoStoreApp
//
//  Created by Neosoft on 22/07/24.
//

import Foundation
import UIKit
extension String {
    func isValidEmail() -> Bool{
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool{
        let passwordRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool{
        let phoneRegex = "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?.{10}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return passwordTest.evaluate(with: self)
    }
    
    func isValidName() -> Bool{
        let nameRegex = "^[a-zA-Z]{3,}$"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: self)
    }
}




