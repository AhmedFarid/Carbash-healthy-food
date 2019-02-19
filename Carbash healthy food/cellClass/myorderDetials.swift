//
//  myorderDetials.swift
//  Carbash healthy food
//
//  Created by farid on 2/7/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class myorderDetials: UITableViewCell {

    @IBOutlet weak var mealFoodsName: UILabel!
    @IBOutlet weak var mealFoodsPrice: UILabel!
    @IBOutlet weak var qty: UILabel!
    
    
    func configuerCell(prodect: myordersdetials) {
        self.mealFoodsName.text = "اسم الوجيه  \(prodect.mealFoodsName)"
        self.mealFoodsPrice.text = "السعر \(prodect.mealFoodsPrice)"
        self.qty.text = "كميه \(prodect.qty)"
    }
    
}
