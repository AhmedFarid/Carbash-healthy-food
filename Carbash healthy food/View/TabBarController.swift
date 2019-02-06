//
//  TabBarController.swift
//  Carbash healthy food
//
//  Created by farid on 2/5/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var count = 0
    var carts = [Cart]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleRefresh()
    }
    
    
    @objc func handleRefresh() {
        API_Cart.cart{ (error: Error?, carts: [Cart]?) in
            if let carts = carts {
                self.carts = carts
                print("xxx\(self.carts)")
                self.tabBar.items![1].badgeValue = "\(carts.count)"
            }
        }
        
    }

}
