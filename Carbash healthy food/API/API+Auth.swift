//
//  API+Auth.swift
//  Carbash healthy food
//
//  Created by farid on 1/31/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Auth: NSObject {
    
    class func register(name: String, email: String, password: String,address: String ,phone: String,image: UIImage, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.register+"?name=\(name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? name)&email=\(email.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? email)&password=\(password.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? password)&address=\(address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? address)&phone=\(phone.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? phone)"
        print(url)
        
        
        Alamofire.upload(multipartFormData: { (form: MultipartFormData) in
            if let data = image.jpegData(compressionQuality: 0.5) {
                form.append(data, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: nil) { (result: SessionManager.MultipartFormDataEncodingResult) in
            switch result {
            case .failure(let error):
                print(error)
                completion(error,false,nil)
                
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress(closure: { (progress: Progress) in
                    print("farido\(progress)")
                })
                upload.responseJSON(completionHandler: { (response: DataResponse<Any>) in
                    switch response.result
                    {
                    case .failure(let error):
                        print(error)
                        completion(error,false,nil)
                        
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
                })
            }
        }
        
    }
    
    class func login(email: String,password: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.login
        print(url)
        let parameters = [
            "email": email,
            "password": password
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
    
    class func restPassword(email: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.restPassword
        print(url)
        let parameters = [
            "email": email
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
}

