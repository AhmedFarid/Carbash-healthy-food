//
//  restPasswordVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class restPasswordVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageText()
        
    }
    
    
    @IBAction func restbutn(_ sender: Any) {
        guard let userName = emailTxt.text, !userName.isEmpty else {
            let messages = NSLocalizedString("enter your Email", comment: "hhhh")
            let title = NSLocalizedString("Login Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        API_Auth.restPassword(email: emailTxt.text ?? "") { (error: Error?, success: Bool, data) in
            if success {
                if data == nil {
                    print("success")
                }else {
                    self.showAlert(title: "rest Password", message: "\(data ?? "")")
                }
                //
            }else {
                self.showAlert(title: "rest Password", message: "\(data ?? "")")
            }
            
        }
    }

    
    func imageText() {
        
        if let myImage = UIImage(named: "Union 155"){
            
            emailTxt.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
    }
}
