//
//  myBakageCell.swift
//  Carbash healthy food
//
//  Created by farid on 2/11/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class myBakageCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    
    func configuerCell(prodect: packages) {
        self.date.text = "\(prodect.day)\n\(prodect.due)"
        self.status.text = "\(prodect.status)"
    }
    
}
