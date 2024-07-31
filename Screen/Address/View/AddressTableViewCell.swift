//
//  AddressTableViewCell.swift
//  NeoStoreApp
//
//  Created by Neosoft on 06/07/24.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!{
        didSet{
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var crossBtn: UIButton!
    var deleteAddress:(()->Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBAction func deleteAddress(sender: UIButton){
        self.deleteAddress?()
    }
    
    
}
