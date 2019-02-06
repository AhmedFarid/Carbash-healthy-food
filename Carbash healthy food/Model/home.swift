//
//  home.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON


class banners: NSObject {
    
    var image: String
    
    init?(dict: [String: JSON]){
        
        guard let image = dict["image"]?.string else {return nil}
        self.image = image
        
    }
}

class homeMeals: NSObject {
    
    var id: String
    var name: String
    var price: String
    var image: String
    
    init?(dict: [String: JSON]){
        
        guard let id = dict["id"]?.string,let name = dict["name"]?.string,let price = dict["price"]?.string,let image = dict["image"]?.string else {return nil}
        self.id = id
        self.name = name
        self.price = price
        self.image = image
        
    }
}

class mailDetials: NSObject {
    
    var id: String
    var name: String
    var qty: String
    
    init?(dict: [String: JSON]){
        
        guard let id = dict["id"]?.string,let name = dict["name"]?.string,let qty = dict["qty"]?.string else {return nil}
        self.id = id
        self.name = name
        self.qty = qty
        
    }
}

class backageBanner: NSObject {
    
    var image: String
    
    init?(dict: [String: JSON]){
        
        guard let image = dict["image"]?.string else {return nil}
        self.image = image
        
    }
}
