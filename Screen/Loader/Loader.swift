//
//  Loader.swift
//  NeoStoreApp
//
//  Created by Neosoft on 15/07/24.
//

import Foundation
import UIKit

class Loader {
    static let shared = Loader()

    private var containerView: UIView = UIView()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

    private init() {
        setupLoader()
    }

    private func setupLoader() {
        containerView.frame = UIScreen.main.bounds
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.7)

        activityIndicator.center = containerView.center
        activityIndicator.color = .black
        containerView.addSubview(activityIndicator)
    }

    func show() {
        guard let window = UIApplication.shared.keyWindow else { return }
        containerView.isHidden = false
        window.addSubview(containerView)
        activityIndicator.startAnimating()
    }

    func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.containerView.isHidden = true
            self.containerView.removeFromSuperview()
        }
        
    }
}
