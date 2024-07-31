//
//  HomeScreenViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 27/06/24.
//

import UIKit

class HomeScreenViewController: UIViewController, UIScrollViewDelegate {
    private let collectionViewCellIdentifier = "collectionViewCell"
    private let pageCollectionCellIdentifier = "PageCollectionCell"
    private let productListningViewControllerIdentifier = "ProductListningViewController"
    @IBOutlet weak var homeScreenCollectionView: UICollectionView!
    @IBOutlet weak var manuBtn: UIBarButtonItem!
    @IBOutlet weak var siderView: UIView!
    @IBOutlet weak var homeScreenLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderleading: NSLayoutConstraint!
    var viewModel = ProductListingsViewModel()
    @IBAction func menuBarBtn(_ sender: UIBarButtonItem) {
        if sliderleading.constant < 0{
            openSidebar()
        }else{
            closeSidebar()
        }
    }
    
    var tabelArray = ["tableicon" , "sofaicon", "chairsicon" , "cupboardicon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registrationCell()
        homeScreenCollectionView.isHidden = false
        initialize()
        siderView.isHidden = true
        sliderleading.constant = -280
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        homeScreenCollectionView.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        let titleLabel = UILabel()
        titleLabel.text = "NeoSTORE"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.alignment = .center
        stackView.axis = .horizontal
        self.navigationItem.titleView = stackView
        UserDefaults.standard.set(true, forKey: "is_login")
    }
    func openSidebar() {
        siderView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.homeScreenLeadingConstraint.constant = 280
            self.sliderleading.constant = 0
            self.view.layoutIfNeeded()
        }) { _ in
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    func closeSidebar() {
        UIView.animate(withDuration: 0.3, animations: {
            self.homeScreenLeadingConstraint.constant = 0
            self.sliderleading.constant = -280
            self.view.layoutIfNeeded()
        }) { _ in
            self.siderView.isHidden = true
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    func registrationCell(){
        let uinib = UINib(nibName: collectionViewCellIdentifier, bundle: nil)
        homeScreenCollectionView.register(uinib, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        let nib = UINib(nibName: pageCollectionCellIdentifier, bundle: nil)
        homeScreenCollectionView.register(nib, forCellWithReuseIdentifier: pageCollectionCellIdentifier)
    }
    func initialize(){
        homeScreenCollectionView.dataSource = self
        homeScreenCollectionView.delegate = self
        homeScreenCollectionView.reloadData()
    }
}
extension HomeScreenViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return tabelArray.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let pageControlTableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCollectionCellIdentifier, for: indexPath) as! PageCollectionCell
            return pageControlTableViewCell
        }else{
            let TableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! collectionViewCell
            let image = tabelArray[indexPath.row]
            TableViewCell.getImagedata(imageValue: image)
            return TableViewCell
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item{
        case 0 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Tables")
            ProductListningViewController.productcategoryid = "1"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
            break
        case 1 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Sofas")
            ProductListningViewController.productcategoryid = "3"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
            break
        case 2 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Chairs")
            ProductListningViewController.productcategoryid = "2"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
            break
        case 3 :
            let ProductListningViewController = self.storyboard?.instantiateViewController(withIdentifier: productListningViewControllerIdentifier) as! ProductListningViewController
            NavigationBarConfigurator.setupNavigationBar(for: ProductListningViewController, withTitle: "Cupboards")
            ProductListningViewController.productcategoryid = "4"
            navigationController?.pushViewController(ProductListningViewController, animated: true)
            break
        default :
            break
        }
    }
}
extension HomeScreenViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: self.view.frame.width, height: 300)
        }else{
            return CGSize(width: self.view.frame.width/2 - 16, height: 193)
        }
    }
}
