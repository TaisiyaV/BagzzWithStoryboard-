//
//  NetworkService.swift
//  Bagzz
//
//  Created by tasya on 15.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash


class NetworkService {
    
    let url = "https://www.cbr.ru/scripts/XML_daily.asp"
    
    var arrayCurrency = [Currency]()
    
    
    
    func getCurrency(onCompleted: @escaping ([Currency]) -> Void,
                     onError: @escaping (Error) -> Void) {
        AF.request(url, method: .get).response { response in
            
            switch response.result {
            case .success(let value):
                
//                var xml = SWXMLHash.parse(value!)
//                print((xml["ValCurs"]["Valute"][0]["Name"].element?.text))
//                print(xml["ValCurs"]["Valute"].element?.text)
//
//                for child in xml["ValCurs"].children {
//                    print(child.element?.name)
//                }
//                print(xml)
                
                guard let value = value else { return }
                
                let xml = SWXMLHash.config { (config) in
                    config.shouldProcessLazily = true
                }.parse(value)

                for elem in xml["ValCurs"]["Valute"].all {

                    var newItem = Currency()
                    if let name = elem["Name"].element?.text {
                        newItem.name = name
                    }
                    if let value = elem["Value"].element?.text {
                        newItem.value = value
                    }
                    self.arrayCurrency.append(newItem)
                }
                onCompleted(self.arrayCurrency)
            
            case .failure(_):
                print("unadable decode data")
                onError(NSError())
                return
            }

        }
    
    }
    
}
