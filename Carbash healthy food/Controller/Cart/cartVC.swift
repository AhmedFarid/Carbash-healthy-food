//
//  cartVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/4/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class cartVC: UIViewController {
    
    
    var carts = [Cart]()
    var cartsss = 0.0
    var count = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        customBackBtton()
        //handleRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleRefresh()
    }
    
    func customBackBtton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    
    @objc private func handleRefresh() {
        self.cartsss = 0.0
        API_Cart.cart{ (error: Error?, carts: [Cart]?) in
            if let carts = carts {
                self.carts = carts
                print("xxx\(self.carts)")
                self.totalPric()
                self.tableView.reloadData()
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[1]
                    tabItem.badgeValue = "\(carts.count)"
                }
            }
        }
        
    }
    
    func totalPric() {
        for cart in carts {
            self.cartsss =  Double(cart.totalPrice) + self.cartsss
        }
        self.totalPrice.text = "\(self.cartsss) ريال"
        print(self.cartsss)
    }
    
    
    
    @IBAction func odrer(_ sender: Any) {
        guard (helper.getAPIToken() != nil)  else {
            let message = NSLocalizedString("please login frist", comment: "hhhh")
            let title = NSLocalizedString("Filed to request order", comment: "profuct list lang")
            self.showAlert(title: title, message: message)
            return
        }
        
        guard (carts.count != 0)  else {
            let message = NSLocalizedString("please Add somthing to cart first", comment: "hhhh")
            let title = NSLocalizedString("Filed to request order", comment: "profuct list lang")
            self.showAlert(title: title, message: message)
            return
        }
        
        performSegue(withIdentifier: "suge", sender: nil)
    }
}

extension cartVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as? cartCell {
            let cartss = carts[indexPath.item]
            cell.configuerCell(prodect: cartss)
            
            cell.add = {
                
                guard (helper.getAPIToken() != nil)  else {
                    let message = NSLocalizedString("please login frist", comment: "hhhh")
                    let title = NSLocalizedString("Filed to request order", comment: "profuct list lang")
                    self.showAlert(title: title, message: message)
                    return
                }
                
                API_Home.postCart(meal_foods_id: cartss.mealFoodId){ (error: Error?, success, data) in
                    if success {
                        self.handleRefresh()
                        let title = NSLocalizedString("Added", comment: "profuct list lang")
                        self.showAlert(title: title, message: data ?? "")
                    }else {
                        self.handleRefresh()
                        print("Error")
                    }
                }
            }
            if cartss.qty != "1" {
                cell.deletBTN.isEnabled = true
                cell.min = {
                    guard (helper.getAPIToken() != nil)  else {
                        let message = NSLocalizedString("please login frist", comment: "hhhh")
                        let title = NSLocalizedString("Filed to request order", comment: "profuct list lang")
                        self.showAlert(title: title, message: message)
                        return
                    }

                    API_Cart.minCart(meal_foods_id: cartss.mealFoodId){ (error: Error?, success, data) in
                        if success {
                            self.handleRefresh()
                            let title = NSLocalizedString("dleted", comment: "profuct list lang")
                            self.showAlert(title: title, message: data ?? "")
                        }else {
                            self.handleRefresh()
                            print("Error")
                        }
                    }
                }
            }else {
                cell.deletBTN.isEnabled = false
            }
            
            cell.deleteBtn = {
                guard (helper.getAPIToken() != nil)  else {
                    let message = NSLocalizedString("please login frist", comment: "hhhh")
                    let title = NSLocalizedString("Filed to request order", comment: "profuct list lang")
                    self.showAlert(title: title, message: message)
                    return
                }

                API_Cart.deleteCart(meal_foods_id: cartss.mealFoodId){ (error: Error?, success, data) in
                    if success {
                        self.handleRefresh()
                        let title = NSLocalizedString("dleted", comment: "profuct list lang")
                        self.showAlert(title: title, message: data ?? "")
                    }else {
                        self.handleRefresh()
                        print("Error")
                    }
                }
            }
            
            return cell
        }else {
            return cartCell()
            
        }
    }
}
