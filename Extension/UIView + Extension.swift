//
//  UIView + Extension.swift
//  NeoStoreApp
//
//  Created by Neosoft on 21/07/24.
//

import Foundation
import UIKit
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
