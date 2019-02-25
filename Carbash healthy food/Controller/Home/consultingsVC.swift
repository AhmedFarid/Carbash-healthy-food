//
//  consultingsVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/7/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class consultingsVC: UIViewController {
    
    @IBOutlet weak var nameTXT: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var emailTXT: UITextField!
    @IBOutlet weak var messageTXT: roundedTxtView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendTXt(_ sender: Any) {
        
        
        guard (helper.getAPIToken() != nil)  else {
            let messages = NSLocalizedString("please login frist", comment: "hhhh")
            let title = NSLocalizedString("Filed to request order", comment: "profuct list lang")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let name = nameTXT.text, !name.isEmpty else {
            let messages = NSLocalizedString("ادخل الاسم", comment: "hhhh")
            let title = NSLocalizedString("طلب استشاره", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        guard let phone = phoneTxt.text, !phone.isEmpty else {
            let messages = NSLocalizedString("ادخل الجوال", comment: "hhhh")
            let title = NSLocalizedString("طلب استشاره", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        guard let email = emailTXT.text, !email.isEmpty else {
            let messages = NSLocalizedString("ادخل البريد الالكتروني", comment: "hhhh")
            let title = NSLocalizedString("طلب استشاره", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        guard let message = messageTXT.text, !message.isEmpty else {
            let messages = NSLocalizedString("ادخل الرساله", comment: "hhhh")
            let title = NSLocalizedString("طلب استشاره", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
//        API_Consultings.consultings(name: nameTXT.text ?? "", email: emailTXT.text ?? "", phone: phoneTxt.text ?? "", message: messageTXT.text ?? ""){ (error: Error?, success, data) in
//            if success {
//                let title = NSLocalizedString("Added", comment: "profuct list lang")
//                self.showAlert(title: title, message: data ?? "")
//            }else {
//                print("Error")
//            }
//        }
        
        performSegue(withIdentifier: "suge", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? orderCartVC{
            destaiantion.amount = 120
            destaiantion.type = "consult"
            destaiantion.name = nameTXT.text ?? ""
            destaiantion.phone = phoneTxt.text ?? ""
            destaiantion.email = emailTXT.text ?? ""
            destaiantion.message = messageTXT.text ?? ""
        }
        
    }
}
