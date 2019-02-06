//
//  Cart.swift
//  Carbash healthy food
//
//  Created by farid on 2/5/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON

class Cart: NSObject {

    
    var cardId: String
    var mealFoodName: String
    var price: String
    var image: String
    var mealFoodId: String
    var qty: String
    var totalPrice: Int
    
    
    init?(dict: [String: JSON]){
        
        guard let cardId = dict["cardId"]?.string,let mealFoodName = dict["mealFoodName"]?.string,let price = dict["price"]?.string,let image = dict["image"]?.string,let qty = dict["qty"]?.string,let totalPrice = dict["totalPrice"]?.int, let mealFoodId = dict["mealFoodId"]?.string else {return nil}
        self.cardId = cardId
        self.mealFoodName = mealFoodName
        self.price = price
        self.image = image
        self.qty = qty
        self.totalPrice = totalPrice
        self.mealFoodId = mealFoodId
        
    }
}
