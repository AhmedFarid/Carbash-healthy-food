//
//  Configs.swift
//  Carbash healthy food
//
//  Created by farid on 2/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class Configs: NSObject {
    
    // MARK: - The default amount and currency that are used for all payments
    static var amount: Int = 0
    static let currency: String = "SAR"
    
    // MARK: - The payment brands for Ready-to-use UI
    static let checkoutPaymentBrands = ["VISA", "MASTER"]
    
    // MARK: - The default payment brand for Payment Button
    static let paymentButtonBrand = "VISA"
    static let paymentButtonBrand2 = "MASTER"
    
    
    // MARK: - The card parameters for SDK & Your Own UI form
    static let cardBrand = ""
    static let cardHolder = ""
    static let cardNumber = ""
    static let cardExpiryMonth = ""
    static let cardExpiryYear = ""
    static let cardCVV = ""
    
    // MARK: - Other constants
    static let asyncPaymentCompletedNotificationKey = "AsyncPaymentCompletedNotificationKey"
    static let urlScheme = "Ebakers.Carbash.payments"
    static let mainColor: UIColor = UIColor.init(red: 2.0/255.0, green: 148.0/255.0, blue: 75.0/255.0, alpha: 1.0)

}
