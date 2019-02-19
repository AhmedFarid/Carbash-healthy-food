//
//  packages.swift
//  Carbash healthy food
//
//  Created by farid on 2/11/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit
import SwiftyJSON

class packages: NSObject {
    
    var day: String
    var due: String
    var status: String
    
    init?(dict: [String: JSON]){
        
        guard let day = dict["day"]?.string,let due = dict["due"]?.string,let status = dict["status"]?.string else {return nil}
        self.day = day
        self.due = due
        self.status = status
    }

}
