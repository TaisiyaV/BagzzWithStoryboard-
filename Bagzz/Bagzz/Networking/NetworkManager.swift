//
//  NetworkManager.swift
//  Bagzz
//
//  Created by tasya on 11.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import Foundation
import Alamofire


class NetworkManager {
    
    let link = "https://jsonplaceholder.typicode.com/photos"
    var dataArray = [BagCatalog]()
    
    
    func getBag(onCompleted: @escaping ([BagCatalog]) -> Void,
                onError: @escaping (Error) -> Void) {

        AF.request(link, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                for item in value as! [[String: AnyObject]] {
                    let bagsData = BagCatalog(title: item["title"] as! String, url: item["url"] as! String)
                    self.dataArray.append(bagsData)
                }
                onCompleted(self.dataArray)
            case .failure(_):
                print("unadable decode data")
                onError(NSError())
                return
            }
        }
    }
}


