//
//  roundedLable.swift
//  Carbash healthy food
//
//  Created by farid on 1/31/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

@IBDesignable
class roundedLable: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
