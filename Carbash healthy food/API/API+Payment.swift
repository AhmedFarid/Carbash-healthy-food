//
//  API+Payment.swift
//  Carbash healthy food
//
//  Created by farid on 2/21/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Payment: NSObject {
    
    
    class func checkoutId1(lng: String,lat: String ,phone: String,street1: String,state: String ,city: String, completion: @escaping (_ error: Error?, _ success: Bool, _ id: String?)->Void) {
        
        let url = URLs.storeData
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        
        
        print(url)
        let parameters = [
            "user_token": user_token,
            "city": city,
            "state": "state",
            "street1": street1,
            "phone": phone,
            "lat": lat,
            "lng": lng
            ] as [String : Any]
        
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
                }else if let id = json["message"][0].string {
                    print(id)
                    completion(nil, true, id)
                }else  {
                    let id = json["message"].string
                    print(id ?? "no")
                    completion(nil, true, id)
                }
                
            }
        }
        
    }
    
    
    
    class func checkoutId(amount: Int, completion: @escaping (_ error: Error?, _ success: Bool, _ id: String?)->Void) {
        
        let url = URLs.checkout
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        
        
        print(url)
        let parameters = [
            "amount": amount,
            "userId": "8ac7a4c8686138d701686fad36ce11a4",
            "password": "kejWhw4yhN",
            "entityId": "8ac7a4c8686138d701686fad698011ae",
            "user_token": user_token
            ] as [String : Any]
        
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
                }else if let id = json["message"][0].string {
                    print(id)
                    completion(nil, true, id)
                }else  {
                    let id = json["id"].string
                    print(id ?? "no")
                    completion(nil, true, id)
                }
                
            }
        }
        
    }
    
    
    class func paymentStatis(id: String, completion: @escaping (_ error: Error?, _ success: Bool, _ id: String?)->Void) {
        
        let url = URLs.paymentId
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        
        
        print(url)
        let parameters = [
            "id": id,
            "userId": "8ac7a4c8686138d701686fad36ce11a4",
            "password": "kejWhw4yhN",
            "entityId": "8ac7a4c8686138d701686fad698011ae",
            "user_token": user_token
            ] as [String : Any]
        
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
                }else if let id = json["message"][0].string {
                    print(id)
                    completion(nil, true, id)
                }else  {
                    let id = json["result"]["description"].string
                    print(id ?? "no")
                    completion(nil, true, id)
                }
                
            }
        }
        
    }
}
