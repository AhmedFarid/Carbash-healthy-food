//
//  Utils.swift
//  Carbash healthy food
//
//  Created by farid on 2/20/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    static func SDKVersion() -> String? {
        if let path = Bundle.main.path(forResource: "OPPWAMobile-Resources.bundle/version", ofType: "plist") {
            if let versionDict = NSDictionary(contentsOfFile: path) as? [String: String] {
                return versionDict["OPPVersion"]
            }
        }
        return ""
    }
    
    static func amountAsString() -> String {
        return String(format: "%.2f", Configs.amount) + " " + Configs.currency
    }
    
    static func showResult(presenter: UIViewController, success: Bool, message: String?) {
        let title = success ? "Success" : "Failure"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        presenter.present(alert, animated: true, completion: nil)
    }
    
    static func configureCheckoutSettings() -> OPPCheckoutSettings {
        let checkoutSettings = OPPCheckoutSettings.init()
        checkoutSettings.paymentBrands = Configs.checkoutPaymentBrands
        checkoutSettings.shopperResultURL = Configs.urlScheme + "://payment"
        
        checkoutSettings.theme.navigationBarBackgroundColor = Configs.mainColor
        checkoutSettings.theme.confirmationButtonColor = Configs.mainColor
        checkoutSettings.theme.accentColor = Configs.mainColor
        checkoutSettings.theme.cellHighlightedBackgroundColor = Configs.mainColor
        checkoutSettings.theme.sectionBackgroundColor = Configs.mainColor.withAlphaComponent(0.05)
        
        return checkoutSettings
    }

}
