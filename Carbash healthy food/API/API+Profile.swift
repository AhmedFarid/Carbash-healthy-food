//
//  API+Profile.swift
//  Carbash healthy food
//
//  Created by farid on 1/31/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API_Profile: NSObject {

    class func profile(completion: @escaping (_ error: Error?, _ success: Bool, _ name: String?,_ email: String?,_ phone: String?,_ address: String?,_ image: String?)->Void) {
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil,nil,nil,nil,nil)
            return
        }
        let url = URLs.getProfile
        let parameters = [
            "user_token": user_token
        ]
        
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil,nil,nil,nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let name = json["message"]["name"].string {
                    let email = json["message"]["email"].string
                    let address = json["message"]["address"].string
                    let phone = json["message"]["phone"].string
                    let image = json["message"]["image"].string
                    completion(nil, true, name,email,phone,address,image)
                }
                
            }
        }
        
    }
    
    class func updateProfile(name: String, email: String,address: String ,phone: String,image: UIImage, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        
        let url = URLs.updateProfile+"?name=\(name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? name)&email=\(email.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? email)&user_token=\(user_token.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? email)&address=\(address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? address)&phone=\(phone.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed) ?? phone)"
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
    
    class func updatePassword(old_password: String,new_password: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        
        guard let user_token = helper.getAPIToken() else {
            completion(nil,false,nil)
            return
        }
        let url = URLs.changePassword
        
        
        print(url)
        let parameters = [
            "user_token" : user_token,
            "old_password": old_password,
            "new_password": new_password
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

