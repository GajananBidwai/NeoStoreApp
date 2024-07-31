//
//  RatingViewController.swift
//  NeoStoreApp
//
//  Created by Neosoft on 15/07/24.
//

import UIKit
import Foundation
class RatingViewController: UIViewController {
    var productName : String?
    var productImage : String?
    var productId : Int?
    var viewModel = RatingViewModel()
    @IBOutlet weak var prouductNameLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!{
        didSet{
            productImageLabel.layer.borderWidth = 1
            productImageLabel.layer.borderColor = UIColor.gray.cgColor
        }
    }
    @IBOutlet weak var startBtn1: UIButton!
    @IBOutlet weak var starBtn2: UIButton!
    @IBOutlet weak var starBtn3: UIButton!
    @IBOutlet weak var starBtn4: UIButton!
    @IBOutlet weak var starBtn5: UIButton!
    @IBOutlet weak var ratingDetailsView: UIView!{
        didSet{
            ratingDetailsView.layer.cornerRadius = 20
            ratingDetailsView.clipsToBounds = true
        }
    }
    @IBOutlet weak var ratingBtn: UIButton!{
        didSet{
            ratingBtn.layer.cornerRadius = 10
            ratingBtn.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        prouductNameLabel.text = productName
        let image = productImage
        let imageUrl = URL(string: image!)
        productImageLabel.kf.setImage(with: imageUrl)
        setRating()
        setUpTapGestureRecognizer()
    }
    private func setUpTapGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    @objc func handleBackgroundTap(_ sender : UITapGestureRecognizer){
        let locate = sender.location(in: view)
        if !ratingDetailsView.frame.contains(locate) {
                    dismiss(animated: true, completion: nil)
        }
    }
    func setRating(){
        let btnArray = [startBtn1 , starBtn2, starBtn3 , starBtn4, starBtn5]
        for (index, starButton) in btnArray.enumerated(){
            starButton?.tag = index + 1
            starButton?.setImage(UIImage(named: "star_unchek"), for: .normal)
            starButton?.tintColor = .gray
        }
    }
    @IBAction func ratingStarBtn(_ sender: UIButton) {
        let rating = sender.tag
        setRating(rating: rating)
    }
    func setRating(rating: Int) {
        let starButtons = [startBtn1, starBtn2, starBtn3, starBtn4, starBtn5]
        for starButton in starButtons {
            if let starButton = starButton {
                if starButton.tag <= rating {
                    starButton.setImage(UIImage(named: "star_check"), for: .normal)
                    starButton.tintColor = .yellow
                } else {
                    starButton.setImage(UIImage(named: "star_unchek"), for: .normal)
                    starButton.tintColor = .gray
                }
            }
        }
    }
    @IBAction func rateNowBtn(_ sender: Any) {
        configuraion()
    }
}
extension RatingViewController{
    func configuraion(){
        viewModel.productId = self.productId
        initViewModel()
        observeEvent()
    }
    func initViewModel(){
        viewModel.fetchData(productId: "\(productId!)")
    }
    func observeEvent(){
        viewModel.eventHandler = { Response in
            switch Response{
            case .Loading:
                Loader.shared.show()
                print("Start Loading")
            case .StopLoading:
                Loader.shared.hide()
                print("Stop Loading")
            case .dataLoaded:
                self.showSuccessAlert()
            case .Error(let error):
                print(error!)
            }
        }
    }
    func showSuccessAlert(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Thanks For rating", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default) { _ in
                self.dismiss(animated: true)
            }
            alert.addAction(okay)
            self.present(alert, animated: true)
        }
    }
}

