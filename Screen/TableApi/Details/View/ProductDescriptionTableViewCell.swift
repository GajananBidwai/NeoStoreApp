//
//  ProductDescriptionTableViewCell.swift
//  NeoStoreApp
//
//  Created by Neosoft on 03/07/24.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descritpitionLabel: UILabel!
    @IBOutlet weak var view: UIView!{
        didSet{
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
