//
//  PageCollectionCell.swift
//  NeoStoreApp
//
//  Created by Neosoft on 27/06/24.
//

import UIKit

class PageCollectionCell: UICollectionViewCell {
    private let pageControlCollectionViewCellIdentifier = "PageControlCollectionViewCell"
    var homePageCollection : HomePageCollection?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Loader.shared.show()
        fetchData()
        registerCell()
        populateData()
        pageControl.currentPage = 0
        
    }

   
    func registerCell(){
        collectionView.register(UINib(nibName: pageControlCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: pageControlCollectionViewCellIdentifier)
    }
    
    func populateData(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
}

extension PageCollectionCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
}
extension PageCollectionCell : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePageCollection?.data.product_categories.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageControlCollectionViewCellIdentifier, for: indexPath) as? PageControlCollectionViewCell else { return UICollectionViewCell() }
        let image = homePageCollection?.data.product_categories[indexPath.item].icon_image
        //cell.getData(imageValue: image!)
        let imageUrl = URL(string: image!)
        cell.pageControllImage.kf.setImage(with: imageUrl)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = collectionView.contentOffset.x / collectionView.frame.width
        pageControl.currentPage = Int(index)
    }

}

extension PageCollectionCell{
    func fetchData(){
        let url = URL(string: Constant.Api.myAccountUrl)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let urlSession = URLSession(configuration: .default)
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        urlRequest.setValue(accessToken, forHTTPHeaderField: "access_token")
        urlSession.dataTask(with: urlRequest) { data, response, error in
            let response = try! JSONDecoder().decode(HomePageCollection.self, from: data!)
            print(response)
            self.homePageCollection = response
            DispatchQueue.main.async { [self] in
                self.collectionView.reloadData()
                pageControl.numberOfPages = homePageCollection?.data.product_categories.count ?? 0
                Loader.shared.hide()
            }
        }.resume()
        
    }
    
    
    
}

