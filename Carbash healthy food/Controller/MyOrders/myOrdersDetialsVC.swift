//
//  myOrdersDetialsVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/7/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class myOrdersDetialsVC: UIViewController {

    var singleItem: myorders?
    var myorderdetial = [myordersdetials]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        customBackBtton()
        handleRefresh()
    }

    
    func customBackBtton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func handleRefresh() {
        API_Myorder.myorderDetials(order_id: singleItem?.orderId ?? ""){ (error: Error?, myorderdetial: [myordersdetials]?) in
            if let myorderdetial = myorderdetial {
                self.myorderdetial = myorderdetial
                print("xxx\(self.myorderdetial)")
                self.tableView.reloadData()
            }
        }
        
    }
}

extension myOrdersDetialsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myorderdetial.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as? myorderDetials {
            let cartss = myorderdetial[indexPath.item]
            cell.configuerCell(prodect: cartss)
            
            return cell
        }else {
            return myorderDetials()
            
        }
    }
}

