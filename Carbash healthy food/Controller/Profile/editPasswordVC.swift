//
//  editProifleVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class editPasswordVC: UIViewController {
    
    @IBOutlet weak var oldPass: UITextField!
    @IBOutlet weak var newPass: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageText()
    }
    
    @IBAction func editPasword(_ sender: Any) {
        
        guard let names = oldPass.text, !names.isEmpty else {
            let messages = NSLocalizedString("enter your name", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = newPass.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        API_Profile.updatePassword(old_password: oldPass.text ?? "", new_password: newPass.text ?? "") { (error: Error?, success: Bool, data) in
            if success {
                if data == nil {
                    print("success")
                }else {
                    self.showAlert(title: "Update Password", message: "\(data ?? "")")
                }
            }else {
                self.showAlert(title: "Update Password", message: "\(data ?? "")")
            }
        }
        
    }
    
    
    func imageText() {
        
        if let myImage = UIImage(named: "Path 3762"){
            
            oldPass.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        
        if let myImage = UIImage(named: "Path 3762"){
            
            newPass.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
    }
    
}
