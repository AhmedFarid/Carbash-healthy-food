//
//  signupVC.swift
//  Carbash healthy food
//
//  Created by farid on 1/29/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class signupVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customBackBtton()
        imageText()
        
    }
    
    
    
    @IBAction func sigupBtn(_ sender: Any) {
    }
    
    
    
    func customBackBtton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func imageText() {
        
        if let myImage = UIImage(named: "Repeat Grid 1"){
            
            name.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "telephone"){
            
            phone.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "facebook-placeholder-for-locate-places-on-maps"){
            
            address.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Union 155"){
            
            email.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Path 3762"){
            
            password.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
    }
    
}
