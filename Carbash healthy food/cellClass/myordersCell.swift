//
//  myordersCell.swift
//  Carbash healthy food
//
//  Created by farid on 2/7/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class myordersCell: UITableViewCell {
    @IBOutlet weak var pricce: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    func configuerCell(prodect: myorders) {
        self.phone.text = " الهاتف \(prodect.phone)"
        self.id.text =  "رقم الطلب \(prodect.orderId)"
        self.address.text = "العنوان  \(prodect.address)"
        self.pricce.text = "السعر \(prodect.totalPrice)"
        self.date.text = "تاريخ الطلب \(prodect.date)"
    }
    
}
