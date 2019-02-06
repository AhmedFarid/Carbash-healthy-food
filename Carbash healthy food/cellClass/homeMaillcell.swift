//
//  homeMaillcell.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class homeMaillcell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var priceName: UILabel!
    

    func configuerCell(prodect: homeMeals) {
        
        
        priceName.text = "\(prodect.name)\n\(prodect.price) ريال "
        
        image.image = UIImage(named: "3")
        let s = ("\(URLs.mainImage)\(prodect.image)")
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        
        image.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            image.kf.setImage(with: url)
            //imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "3"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
