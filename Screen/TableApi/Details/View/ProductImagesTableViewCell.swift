//
//  ProductImagesTableViewCell.swift
//  NeoStoreApp
//
//  Created by Neosoft on 03/07/24.
//

import UIKit
import Kingfisher

class ProductImagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    static let identifier = "ProductImagesTableViewCell"
    static let imageIdentifier = "ImagesCollectionViewCell"
    var isSelectedImage = 0
    @IBOutlet weak var productImageLabel: UIImageView!{
        didSet{
            productImageLabel.layer.borderWidth = 1
            productImageLabel.layer.borderColor = UIColor.green.cgColor
        }
    }
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    @IBOutlet weak var view: UIView!{
        didSet{
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
        }
    }
    
    var productDetails : ProductDetails?{
        didSet{
            productImageCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        registerXibWithCollectionView()
        initializeTableView()
    }
    func registerXibWithCollectionView(){
        let uinib = UINib(nibName: ProductImagesTableViewCell.imageIdentifier, bundle: nil)
        productImageCollectionView.register(uinib, forCellWithReuseIdentifier: ProductImagesTableViewCell.imageIdentifier)
    }
    func initializeTableView(){
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
    }
    
}
extension ProductImagesTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetails?.data.product_images.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = productDetails?.data.product_images[indexPath.row].image
        if image != nil{
            let imageUrl = URL(string: image!)
            productImageLabel.kf.setImage(with: imageUrl)
        }
        isSelectedImage = indexPath.row
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ImagesCollectionViewCell = self.productImageCollectionView.dequeueReusableCell(withReuseIdentifier: ProductImagesTableViewCell.imageIdentifier, for: indexPath) as! ImagesCollectionViewCell
        let image = productDetails?.data.product_images[indexPath.row].image
        if image != nil{
            let imageUrl = URL(string: image!)
            ImagesCollectionViewCell.productImages.kf.setImage(with: imageUrl)
            
        }
        ImagesCollectionViewCell.productImages.layer.borderWidth = 1
        ImagesCollectionViewCell.productImages.layer.borderColor = (isSelectedImage == indexPath.row) ? UIColor.red.cgColor :  UIColor.gray.cgColor

        return ImagesCollectionViewCell
    }
}
extension ProductImagesTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/3-20, height: 75)
    }
}
