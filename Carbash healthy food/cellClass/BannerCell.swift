//
//  BannerCell.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configuerCell(prodect: banners) {
        
        imageView.image = UIImage(named: "3")
        let s = ("\(URLs.mainImage)\(prodect.image)")
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        
        imageView.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            imageView.kf.setImage(with: url)
            //imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "3"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
