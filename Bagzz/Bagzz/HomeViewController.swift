//
//  ViewController.swift
//  Bagzz
//
//  Created by tasya on 09.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    var bags = [BagCatalog]()
    var arrayToDisplay: [BagCatalog] = []
    
    var carouselArray = ["bags1", "bags2"]
    var isLoading = false
    
    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var catalogCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingLayoutCarousel()
        settingLayoutCatalog()
        
        catalogCollectionView.register(UINib(nibName: "CollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        
        loadData()
       
    }
    
    
    func settingLayoutCarousel() {
        
        let itemSize = UIScreen.main.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3

        carouselCollectionView.collectionViewLayout = layout
    }
    
    func settingLayoutCatalog() {
        let itemWidth = (UIScreen.main.bounds.width - 35)/2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: 210)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 24
        layout.sectionInset.left = 11
        layout.sectionInset.right = 11
        layout.sectionInset.bottom = 85
        catalogCollectionView.collectionViewLayout = layout
    }

    @IBAction func leftButton(_ sender: Any) {
        let visibleItems: NSArray = carouselCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.row < carouselArray.count && nextItem.row >= 0 {
            carouselCollectionView.scrollToItem(at: nextItem, at: .right, animated: true)
        }
    }
    
    @IBAction func rightButton(_ sender: Any) {
        let visibleItems: NSArray = carouselCollectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < carouselArray.count {
               carouselCollectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
        
    }
    
    
    func loadData() {
        let networkManager = NetworkManager()
            
        networkManager.getBag(onCompleted: { (bag) in
            self.bags = bag
            self.arrayToDisplay = Array(self.bags[0..<20])
            self.catalogCollectionView.reloadData()
        }) { (error) in
            print("error: \(error)")
        }
    }
    
     
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == carouselCollectionView) {
        return carouselArray.count
        }
        
        return arrayToDisplay.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == catalogCollectionView {
            let cell2 = catalogCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            cell2.image.downloaded(from: arrayToDisplay[indexPath.item].url)
            cell2.title.text = arrayToDisplay[indexPath.item].title
            return cell2
        }

        let cell = carouselCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.image.image = UIImage(named: carouselArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row == arrayToDisplay.count - 2 && !self.isLoading {
            self.isLoading = true
            let start = arrayToDisplay.count
            let end = start + 20
            DispatchQueue.global().async {
                for i in start...end {
                        self.arrayToDisplay.append(self.bags[i])
                }
                DispatchQueue.main.async {
                    self.catalogCollectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
}

