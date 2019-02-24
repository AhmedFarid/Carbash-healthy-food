//
//  orderCartVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/7/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import MapKit



class orderCartVC: UIViewController, CLLocationManagerDelegate{
    
    
    var lat = 0.0
    var long = 0.0
    var amount = 0
    var type = ""
    var id = ""
    var name = ""
    var phone = ""
    var email = ""
    var message = ""
    
    
    
    
    @IBOutlet weak var phoneBTN: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var streat: UITextField!
    
    
    
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        
        /* you can use these values*/
        let lat = location.coordinate.latitude
        self.lat = lat
        let long = location.coordinate.longitude
        self.long = long
    }
    
    
    
    
    @IBAction func order(_ sender: Any) {
        
        guard (helper.getAPIToken() != nil)  else {
            let message = NSLocalizedString("please login frist", comment: "hhhh")
            let title = NSLocalizedString("Filed to request order", comment: "profuct list lang")
            self.showAlert(title: title, message: message)
            return
        }
        
        guard let password = phoneBTN.text, !password.isEmpty else {
            let messages = NSLocalizedString("ادخل رقم الجوال", comment: "hhhh")
            let title = NSLocalizedString("Order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let states = state.text, !states.isEmpty else {
            let messages = NSLocalizedString("ادخل المحافظه", comment: "hhhh")
            let title = NSLocalizedString("Order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let citys = city.text, !citys.isEmpty else {
            let messages = NSLocalizedString("ادخل المدينه", comment: "hhhh")
            let title = NSLocalizedString("Order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let streats = streat.text, !streats.isEmpty else {
            let messages = NSLocalizedString("ادخل الشارع", comment: "hhhh")
            let title = NSLocalizedString("Order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        API_Payment.checkoutId1(lng: "\(long)", lat: "\(lat)", phone: phoneBTN.text ?? "", street1: streats, state: states, city: citys) { (error: Error?, success, id) in
            if success {
                if id == "success" {
                    self.performSegue(withIdentifier: "suge", sender: nil)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? paymentVC{
            destaiantion.amount = self.amount
            destaiantion.phone = phoneBTN.text ?? ""
            destaiantion.lat = lat
            destaiantion.long = long
            destaiantion.type = type
            destaiantion.id = id
            destaiantion.name = name
            destaiantion.phone = phone
            destaiantion.email = email
            destaiantion.message = message
            
        }
    }
    
    
}
