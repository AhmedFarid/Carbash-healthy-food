//
//  helper.swift
//  Carbash healthy food
//
//  Created by farid on 1/31/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class helper: NSObject {
    class func restartApp(){
        guard let window = UIApplication.shared.keyWindow else {return}
        let sb = UIStoryboard(name: "home", bundle: nil)
        var vc: UIViewController
        if getAPIToken() == nil {
            vc = sb.instantiateInitialViewController()!
        }else {
            vc = sb.instantiateViewController(withIdentifier: "main")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func dleteAPIToken() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "user_token")
        def.synchronize()
        
        restartApp()
    }
    
    class func saveAPIToken(token: String) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "user_token")
        def.synchronize()
        
        restartApp()
    }
    
    class func getAPIToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_token") as? String
    }
}
