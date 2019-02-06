//
//  cartCell.swift
//  Carbash healthy food
//
//  Created by farid on 2/5/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class cartCell: UITableViewCell {

    
    

    
    @IBOutlet weak var imagesss: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var qnty: UILabel!
    @IBOutlet weak var deletBTN: UIButton!
    
    var add: (()->())?
    var min: (()->())?
    var deleteBtn: (()->())?
    
    func configuerCell(prodect: Cart) {
        
        self.nameTxt.text = "\(prodect.mealFoodName)\n\(prodect.price) ريال"
        self.qnty.text = prodect.qty
        imagesss.image = UIImage(named: "3")
        let s = ("\(URLs.mainImage)\(prodect.image)")
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        
        imagesss.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            imagesss.kf.setImage(with: url)
            //imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "3"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    @IBAction func add(_ sender: Any) {
        add?()
    }
    
    @IBAction func min(_ sender: Any) {
        min?()
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        deleteBtn?()
    }
    
}
