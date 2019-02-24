//
//  Request.swift
//  Carbash healthy food
//
//  Created by farid on 2/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class Request: NSObject {
    
    
    // Test merchant server domain
    static let serverDomain = "http://52.59.56.185:80"
    
//    static func requestCheckoutID(amount: Double, currency: String, completion: @escaping (String?) -> Void) {
//        let parameters: [String:String] = [
//            "amount": String(format: "%.2f", amount),
//            "currency": currency,
//            // Store notificationUrl on your server to change it any time without updating the app.
//            "notificationUrl": serverDomain + "/notification",
//            "paymentType": "PA",
//            "testMode": "INTERNAL"
//        ]
//        var parametersString = ""
//        for (key, value) in parameters {
//            parametersString += key + "=" + value + "&"
//        }
//        parametersString.remove(at: parametersString.index(before: parametersString.endIndex))
//
//        let url = serverDomain + "/token?" + parametersString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let request = NSURLRequest(url: URL(string: url)!)
//        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                let checkoutID = json?["checkoutId"] as? String
//                completion(checkoutID)
//            } else {
//                completion(nil)
//            }
//            }.resume()
//    }
//    
    static func requestPaymentStatus(resourcePath: String, completion: @escaping (Bool) -> Void) {
        let url = URLs.paymentId + "/status?resourcePath=" + resourcePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let request = NSURLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let transactionStatus = json?["paymentResult"] as? String
                completion(transactionStatus == "OK")
            } else {
                completion(false)
            }
            }.resume()
    }
}
