//
//  ConverterViewController.swift
//  Bagzz
//
//  Created by tasya on 15.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    var currency = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCurrency()
        
    }
    
    
    func loadCurrency() {
        let provider = NetworkService()
        provider.getCurrency(onCompleted: { (currency) in
            self.currency = currency
            print(currency)
        }) { (error) in
            print("error: \(error)")
        }
    }



}
