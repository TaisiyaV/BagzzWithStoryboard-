//
//  TabBarController.swift
//  Bagzz
//
//  Created by tasya on 11.03.2021.
//  Copyright © 2021 Taisiya V. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .black
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.barTintColor = .clear
        tabBar.isTranslucent = true
        

//        let viewTabBar = UIView(frame: .zero)
//        viewTabBar.backgroundColor = .red
//        viewTabBar.layer.cornerRadius = 32
//        viewTabBar.layer.shadowColor = UIColor.black.cgColor
//        viewTabBar.layer.shadowOffset = CGSize(width: 0.5, height: 4.0)
//        viewTabBar.layer.shadowOpacity = 0.1
//        viewTabBar.layer.shadowRadius = 5.0
//
//        tabBar.addSubview(viewTabBar)
//
//        viewTabBar.translatesAutoresizingMaskIntoConstraints = false
//        viewTabBar.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
//        viewTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: 11).isActive = true
//        viewTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor, constant: -11).isActive = true
//        viewTabBar.heightAnchor.constraint(equalToConstant: 65).isActive = true

         
    }


    
}
