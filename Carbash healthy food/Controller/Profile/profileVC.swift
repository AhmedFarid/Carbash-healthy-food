//
//  profileVC.swift
//  Carbash healthy food
//
//  Created by farid on 1/31/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import Kingfisher

class profileVC: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: roundedLable!
    @IBOutlet weak var email: roundedLable!
    @IBOutlet weak var phone: roundedLable!
    @IBOutlet weak var address: roundedLable!
    
    var images = ""
    var names = ""
    var emails = ""
    var phones = ""
    var addreessss = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customBackBtton()
        getDat()
        
        self.image.layer.borderWidth = 3.0
        self.image.layer.borderColor =  #colorLiteral(red: 0.3254901961, green: 0.4431372549, blue: 0.2823529412, alpha: 1)
        self.image.layer.cornerRadius = self.image.frame.size.width / 2
        self.image.clipsToBounds = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDat()
    }
    
    func customBackBtton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    func getDat() {
        API_Profile.profile { (error: Error?, success: Bool, name,email,phone,address,image)  in
            if success {
                self.name.text = "الاسم : \(name ?? "")"
                self.names = name ?? ""
                self.email.text = "الاميل : \(email ?? "")"
                self.emails = email ?? ""
                self.phone.text = "الجوال : \(phone ?? "")"
                self.phones = phone ?? ""
                self.address.text = "العنوان : \(address ?? "")"
                self.addreessss = address ?? ""
                self.images = image ?? ""
                
                self.image.image = UIImage(named: "3")
                let s = ("\(URLs.mainImage)\(image ?? "")")
                let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                let encodedURL = NSURL(string: encodedLink!)! as URL
                
                self.image.kf.indicatorType = .activity
                if let url = URL(string: "\(encodedURL)") {
                    print("g\(url)")
                    self.image.kf.setImage(with: url)
                    //imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "3"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }else {
            }
            
        }
    }
    
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: nil)
        
        guard (helper.getAPIToken() != nil)  else {
            let message = NSLocalizedString("please login frist", comment: "msg list lang")
            self.showAlert(title: "Filed", message: message)
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let distantion = segue.destination as? editProfileVC{
            distantion.namess = names
            distantion.emil = emails
            distantion.phonessss = phones
            distantion.addreessss = addreessss
            distantion.imges = images
            
        }
    }
}
