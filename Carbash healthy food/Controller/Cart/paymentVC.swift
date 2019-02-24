//
//  paymentVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class paymentVC: UIViewController, OPPCheckoutProviderDelegate{
    
    
    var amount = 0
    var checkoutIDs = ""
    var lat = 0.0
    var long = 0.0
    var phone = ""
    var type = ""
    var id = ""
    var name = ""
    var email = ""
    var message = ""
    
    
    @IBOutlet var paymentButton2: UIButton!
    @IBOutlet var processingView: UIActivityIndicatorView!
    @IBOutlet var amountLabel: UILabel!
    
    
    
    
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processingView.isHidden = true
        print("\(amount)")
        self.title = "Payment button"
        self.amountLabel.text = "\(amount) SAR"
        Configs.amount = amount
    }
    
    
    @IBAction func paymentButtonAction2(_ sender: UIButton) {
        processingView.isHidden = false
        self.processingView.startAnimating()
        sender.isEnabled = false
        
        API_Payment.checkoutId(amount: amount) { (error: Error?, success, checkoutID) in
            if success{
                print("xxxx\(checkoutID ?? "")")
                self.checkoutIDs = checkoutID ?? ""
                self.processingView.stopAnimating()
                sender.isEnabled = true
                
                guard let checkoutID = checkoutID else {
                    Utils.showResult(presenter: self, success: false, message: "Checkout ID is empty")
                    return
                }
                
                self.checkoutProvider = self.configureCheckoutProvider(checkoutID: checkoutID)
                self.checkoutProvider?.delegate = self
                self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
                    DispatchQueue.main.async {
                        self.handleTransactionSubmission(transaction: transaction, error: error)
                    }
                }, cancelHandler: nil)
                self.processingView.isHidden = true
            }
        }
    }
    
    
    // MARK: - OPPCheckoutProviderDelegate methods
    
    // This method is called right before submitting a transaction to the Server.
    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, continueSubmitting transaction: OPPTransaction, completion: @escaping (String?, Bool) -> Void) {
        // To continue submitting you should call completion block which expects 2 parameters:
        // checkoutID - you can create new checkoutID here or pass current one
        // abort - you can abort transaction here by passing 'true'
        completion(transaction.paymentParams.checkoutID, false)
    }
    
    // MARK: - Payment helpers
    
    func handleTransactionSubmission(transaction: OPPTransaction?, error: Error?) {
        guard let transaction = transaction else {
            Utils.showResult(presenter: self, success: false, message: error?.localizedDescription)
            return
        }
        
        self.transaction = transaction
        if transaction.type == .synchronous {
            // If a transaction is synchronous, just request the payment status
            self.PaymentStatus()
        } else if transaction.type == .asynchronous {
            // If a transaction is asynchronous, SDK opens transaction.redirectUrl in a browser
            // Subscribe to notifications to request the payment status when a shopper comes back to the app
            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: Configs.asyncPaymentCompletedNotificationKey), object: nil)
        } else {
            Utils.showResult(presenter: self, success: false, message: "Invalid transaction")
        }
    }
    
    func configureCheckoutProvider(checkoutID: String) -> OPPCheckoutProvider? {
        let provider = OPPPaymentProvider.init(mode: .test)
        let checkoutSettings = Utils.configureCheckoutSettings()
        checkoutSettings.storePaymentDetails = .prompt
        return OPPCheckoutProvider.init(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
    }
    
    
    func PaymentStatus() {
        
        //        guard let resourcePath = self.transaction?.resourcePath else {
        //            Utils.showResult(presenter: self, success: false, message: "Resource path is invalid")
        //            return
        //        }
        
        self.transaction = nil
        self.processingView.startAnimating()
        
        
        API_Payment.paymentStatis(id: checkoutIDs) { (error: Error?, success, checkoutID) in
            if success {
                print(checkoutID ?? "")
                self.processingView.stopAnimating()
                let message = success ? "Your payment was successful" : "Your payment was not successful"
                Utils.showResult(presenter: self, success: success, message: message)
                if message == "Your payment was successful" {
                    if self.type == "cart" {
                        self.cart()
                    }else if  self.type == "bakage" {
                        API_Package.subscribe(package_id: self.id){ (error: Error?, success: Bool, data) in
                            if success {
                                self.showAlert(title: "اشتراك", message: data ?? "")
                            }else {
                                
                            }
                        }
                    }else if self.type == "consult" {
                        API_Consultings.consultings(name: self.name, email: self.email, phone: self.phone, message: self.message){ (error: Error?, success, data) in
                            if success {
                                let title = NSLocalizedString("Added", comment: "profuct list lang")
                                self.showAlert(title: title, message: data ?? "")
                            }else {
                                print("Error")
                            }
                        }
                        
                    }
                }
                
            }
            
        }
    }
    
    func cart() {
        API_Cart.orderCart(phone: phone, lat: lat, lng: long){ (error: Error?, success, data, totalprice) in
            if success {
                let title = NSLocalizedString("Added", comment: "profuct list lang")
                self.showAlert(title: title, message:"رقم الطلب  \(data ?? 0)\nالسعر \(totalprice ?? 0)")
            }else {
                print("Error")
            }
        }
    }
    
    func requestPaymentStatus() {
        guard let resourcePath = self.transaction?.resourcePath else {
            Utils.showResult(presenter: self, success: false, message: "Resource path is invalid")
            return
        }
        
        self.transaction = nil
        self.processingView.startAnimating()
        Request.requestPaymentStatus(resourcePath: resourcePath) { (success) in
            DispatchQueue.main.async {
                let message = success ? "Your payment was successful" : "Your payment was not successful"
                Utils.showResult(presenter: self, success: success, message: message)
            }
        }
    }
    
    // MARK: - Async payment callback
    
    @objc func didReceiveAsynchronousPaymentCallback() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: Configs.asyncPaymentCompletedNotificationKey), object: nil)
        self.checkoutProvider?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
                self.PaymentStatus()
            }
        }
    }
}
