//
//  TextField.swift
//  NeoStoreApp
//
//  Created by Neosoft on 18/07/24.
//

import UIKit

import UIKit

class NavigationBarConfigurator {
    static func setupNavigationBar(for viewController: UIViewController, withTitle title: String) {
        viewController.navigationController?.navigationBar.backgroundColor = .red
        viewController.navigationController?.navigationBar.barTintColor = .red
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        viewController.navigationItem.titleView = titleLabel
    
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(viewController, action: #selector(viewController.backButtonTapped), for: .touchUpInside)
        backButton.tintColor = .white
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "search_icon"), for: .normal)
        searchButton.addTarget(viewController, action: #selector(viewController.searchButtonTapped), for: .touchUpInside)
        searchButton.tintColor = .white
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
}

extension UIViewController {
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonTapped() {
        print("Search button tapped")
    }
}


