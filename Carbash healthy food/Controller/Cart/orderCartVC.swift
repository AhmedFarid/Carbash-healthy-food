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
    
    @IBOutlet weak var phoneBTN: UITextField!
    @IBOutlet weak var addressBTN: UITextField!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    
    
    @IBAction func myLocation(_ sender: Any) {
        
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
            let messages = NSLocalizedString("enter your Phone", comment: "hhhh")
            let title = NSLocalizedString("Order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let address = addressBTN.text, !address.isEmpty else {
            let messages = NSLocalizedString("enter your address", comment: "hhhh")
            let title = NSLocalizedString("Order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        API_Cart.orderCart(phone: phoneBTN.text ?? "", address: addressBTN.text ?? "", lat: lat, lng: long){ (error: Error?, success, data, totalprice) in
            if success {
                let title = NSLocalizedString("Added", comment: "profuct list lang")
                self.showAlert(title: title, message:"رقم الطلب  \(data ?? 0)\nالسعر \(totalprice ?? 0)")
            }else {
                print("Error")
            }
        }
        
    }
    
    
}
