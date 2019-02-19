//
//  API + Package.swift
//  Carbash healthy food
//
//  Created by farid on 2/10/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Package: NSObject {
    
    
    class func subscribe(package_id: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.subscribe
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        
        
        print(url)
        let parameters = [
            "package_id": package_id,
            "user_token": user_token
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
                }else if let data = json["message"][0].string {
                    print(data)
                    completion(nil, true, data)
                }else  {
                    let data = json["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
    
    class func getSubscribe (completion: @escaping (_ error: Error?,_ success: Bool,_ sparParts: [packages]?, _ period: Int?, _ packageName: String? , _ wait: Int?, _ arrived: Int?, _ image: String?)-> Void) {
        
        let url = URLs.getSubscribe
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil,nil,nil,nil,nil,nil)
            return
        }
        
        let parameters = [
            "user_token":user_token
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
                guard let dataArray = json["message"]["data"].array else{
                    completion(nil, false,nil,nil,nil,nil,nil,nil)
                    return
                }
                print(dataArray)
                var products = [packages]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = packages.init(dict: data){
                        products.append(prodect)
                    }
                }
                
                if let period = json["message"]["period"].int {
                    let packageName = json["message"]["packageName"].string
                    let wait = json["message"]["wait"].int
                    let arrived = json["message"]["arrived"].int
                    let image = json["message"]["image"].string
                    
                    completion(nil,  true, products,period,packageName, wait, arrived, image)
                }
            }
        }
    }
    


}
