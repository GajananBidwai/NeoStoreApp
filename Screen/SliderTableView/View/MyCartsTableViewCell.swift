//
//  MyCartTableViewCell.swift
//  NeoStoreApp
//
//  Created by Neosoft on 25/07/24.
//

import UIKit

class MyCartsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cartItemCount: UILabel!{
        didSet{
            cartItemCount.layer.cornerRadius = 20
            cartItemCount.clipsToBounds = true
        }
    }
    @IBOutlet weak var cartImageLabel: UIImageView!
    @IBOutlet weak var cartLabel: UILabel!{
        didSet{
            cartLabel.text = "My Carts"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
