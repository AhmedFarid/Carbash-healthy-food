//
//  API+Home.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class API_Home: NSObject {
    
    class func banner (completion: @escaping (_ error: Error?,_ sparParts: [banners]?)-> Void) {
        
        let url = URLs.banners
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["message"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [banners]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = banners.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    
    class func homeMeal (completion: @escaping (_ error: Error?,_ sparParts: [homeMeals]?)-> Void) {
        
        let url = URLs.homeMeal
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["message"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [homeMeals]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = homeMeals.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    
    class func homeMealdetails (category_id: String, completion: @escaping (_ error: Error?,_ sparParts: [mailDetials]?)-> Void) {
        
        let url = URLs.detailsMealFood
        
        let parameters = [
            "meal_food_id": category_id
        ]
        
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["message"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [mailDetials]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = mailDetials.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func mealFood (completion: @escaping (_ error: Error?,_ sparParts: [homeMeals]?)-> Void) {
        
        let url = URLs.mealFood
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["message"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [homeMeals]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = homeMeals.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func detailsPackage (type: String, completion: @escaping (_ error: Error?,_ success: Bool,_ sparParts: [backageBanner]?, _ id: String?, _ name: String? , _ price: String?, _ type: String?, _ description: String?)-> Void) {
        
        let url = URLs.detailsPackages
        
        let parameters = [
        "type":type
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil,nil,nil,nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["message"]["imagePackages"].array else{
                    completion(nil, false,nil,nil,nil,nil,nil,nil)
                    return
                }
                print(dataArray)
                var products = [backageBanner]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = backageBanner.init(dict: data){
                        products.append(prodect)
                    }
                }
                
                if let id = json["message"]["id"].string {
                    let name = json["message"]["name"].string
                    let price = json["message"]["price"].string
                    let type = json["message"]["type"].string
                    let description = json["message"]["description"].string
                
                completion(nil,  true, products,id, name, price, type, description)
                }
            }
        }
    }
    
    
    
    class func postCart(meal_foods_id: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        let url = URLs.postCart
        
        
        print(url)
        let parameters = [
            "user_token" : user_token,
            "meal_foods_id": meal_foods_id
        ]
        
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false, nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let user_token = json["message"]["userToken"].string {
                    print("user token \(user_token)")
                    helper.saveAPIToken(token: user_token)
                    completion(nil, true , nil)
                }else {
                    let data = json["message"]["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
}
