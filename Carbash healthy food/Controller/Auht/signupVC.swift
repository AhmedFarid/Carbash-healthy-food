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
    @IBOutlet weak var imageuser: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customBackBtton()
        imageText()
        
    }
    
    var picker_imag: UIImage? {
        didSet{
            guard let image = picker_imag else {return}
            imageuser.isHidden = false
            self.imageuser.image = image
        }
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        piker.sourceType = .photoLibrary
        piker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Chose A Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                piker.sourceType = .camera
                self.present(piker, animated: true, completion: nil)
            }else {
                print("notFound")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            piker.sourceType = .photoLibrary
            self.present(piker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    @IBAction func sigupBtn(_ sender: Any) {
        guard let names = name.text, !names.isEmpty else {
            let messages = NSLocalizedString("enter your name", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phone.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let emails = email.text, !emails.isEmpty else {
            let messages = NSLocalizedString("enter your Email", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwords = password.text, !passwords.isEmpty else {
            let messages = NSLocalizedString("enter your password", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        if isValidEmail(testStr: emails) == false {
            let messages = NSLocalizedString("email not correct", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
        }
        
        guard let addresss = address.text, !addresss.isEmpty else {
            let messages = NSLocalizedString("enter your address", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        API_Auth.register(name: name.text ?? "", email: email.text ?? "",  password: password.text ?? "",  address: address.text ?? "", phone: phone.text ?? "", image: imageuser.image ?? #imageLiteral(resourceName: "1")) { (error: Error?, success: Bool, data) in
            if success {
                if data == nil {
                    print("success")
                }else {
                    self.showAlert(title: "Register Filed", message: "\(data ?? "") Sorry Try again")
                }
                //
            }else {
                self.showAlert(title: "Register Filed", message: "\(data ?? "") Sorry Try again")
            }
            
        }
    }
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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


extension signupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.picker_imag = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.picker_imag = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
