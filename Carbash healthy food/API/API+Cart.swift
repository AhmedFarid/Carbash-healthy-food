//
//  API+Cart.swift
//  Carbash healthy food
//
//  Created by farid on 2/5/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class API_Cart: NSObject {

    class func cart (completion: @escaping (_ error: Error?,_ sparParts: [Cart]?)-> Void) {
        
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        
        let url = URLs.getCart
        
        let parameters = [
            "user_token" : user_token
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
                guard let dataArray = json["message"]["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [Cart]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = Cart.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    
    class func minCart(meal_foods_id: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        let url = URLs.minCart
        
        
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
                    let data = json["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
    
    class func deleteCart(meal_foods_id: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        let url = URLs.deleteCart
        
        
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
                    let data = json["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
    
    class func orderCart(phone: String, lat: Double, lng: Double, completion: @escaping (_ error: Error?, _ success: Bool, _ data: Int?, _ totalePrice: Int?)->Void) {
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil,nil)
            return
        }
        let url = URLs.postOrder
        
        
        print(url)
        let parameters = [
            "user_token" : user_token,
            "phone": phone,
            "lat": lat,
            "lng": lng
            ] as [String : Any]
        
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false, nil, nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let user_token = json["message"]["userToken"].string {
                    print("user token \(user_token)")
                    helper.saveAPIToken(token: user_token)
                    completion(nil, true , nil,nil)
                }else {
                    let data = json["message"]["orderId"].int
                    let totalePrice = json["message"]["total"].int
                    print(data ?? "no")
                    completion(nil, true, data,totalePrice)
                }
                
            }
        }
        
    }
}
