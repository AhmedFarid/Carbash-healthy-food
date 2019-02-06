//
//  foodDetialsCell.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class foodDetialsCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var qun: UILabel!
    
    func configuerCell(prodect: mailDetials) {
        
        
        name.text = " مكونات الوجبه:\(prodect.name)"
        qun.text = " الكمية: \(prodect.qty)"
    }
}
