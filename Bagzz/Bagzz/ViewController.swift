//
//  ViewController.swift
//  Bagzz
//
//  Created by tasya on 09.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var bags = [BagCatalog]()
    var arrayToDisplay: [BagCatalog] = []
    var carouselArray = ["bags1", "bags2"]
    var isLoading = false

    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var catalogCollectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingLayout()
        
        catalogCollectionView.register(UINib(nibName: "CollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        
        fetchData()
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
    
    func settingLayout() {
        let itemSize = UIScreen.main.bounds.width

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3

        carouselCollectionView.collectionViewLayout = layout
    }
    
    
    func fetchData() {

        AF.request("https://jsonplaceholder.typicode.com/photos", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                for item in value as! [[String: AnyObject]] {
                    let bagsData = BagCatalog(title: item["title"] as! String, thumbnailUrl: item["thumbnailUrl"] as! String)
                    self.bags.append(bagsData)
                }
            case .failure(_):
                print("error")
            }
            self.arrayToDisplay = Array(self.bags[0..<20])
            self.catalogCollectionView.reloadData()
        }
    }
    
  
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if (collectionView == carouselCollectionView) {
            return carouselArray.count
         }
         
         return arrayToDisplay.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == catalogCollectionView {
            let cell2 = catalogCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2

            cell2.image.downloaded(from: arrayToDisplay[indexPath.item].thumbnailUrl)
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
