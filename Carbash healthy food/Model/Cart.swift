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


class myorders: NSObject {
    
    
    var orderId: String
    var totalPrice: String
    var date: String
    var address: String
    var phone: String
    var lat: String
    var lng: String
    
    
    init?(dict: [String: JSON]){
        
        guard let orderId = dict["orderId"]?.string,let totalPrice = dict["totalPrice"]?.string,let date = dict["date"]?.string,let address = dict["address"]?.string,let phone = dict["phone"]?.string,let lat = dict["lat"]?.string, let lng = dict["lng"]?.string else {return nil}
        self.orderId = orderId
        self.totalPrice = totalPrice
        self.date = date
        self.address = address
        self.phone = phone
        self.lat = lat
        self.lng = lng
        
    }
}

class myordersdetials: NSObject {
    
    var mealFoodsId: String
    var mealFoodsName: String
    var mealFoodsPrice: String
    var qty: String
    
    init?(dict: [String: JSON]){
        
        guard let mealFoodsId = dict["mealFoodsId"]?.string,let mealFoodsName = dict["mealFoodsName"]?.string,let mealFoodsPrice = dict["mealFoodsPrice"]?.string,let qty = dict["qty"]?.string else {return nil}
        self.mealFoodsId = mealFoodsId
        self.mealFoodsName = mealFoodsName
        self.mealFoodsPrice = mealFoodsPrice
        self.qty = qty
    }
}



