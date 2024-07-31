//
//  collectionViewCell.swift
//  NeoStoreApp
//
//  Created by Neosoft on 27/06/24.
//

import UIKit

class collectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    func getImagedata(imageValue: String){
        productImage.image = UIImage(named: imageValue)
    }
}
