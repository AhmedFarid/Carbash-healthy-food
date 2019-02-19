//
//  API + Myorder.swift
//  Carbash healthy food
//
//  Created by farid on 2/7/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API_Myorder: NSObject {
    
    class func myorder (completion: @escaping (_ error: Error?,_ sparParts: [myorders]?)-> Void) {
        
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        
        let url = URLs.getOrder
        
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
                guard let dataArray = json["message"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [myorders]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = myorders.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func myorderDetials (order_id: String, completion: @escaping (_ error: Error?,_ sparParts: [myordersdetials]?)-> Void) {
        
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        
        let url = URLs.getOrderDetails
        
        let parameters = [
            "user_token" : user_token,
            "order_id":order_id
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
                var products = [myordersdetials]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = myordersdetials.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
}

