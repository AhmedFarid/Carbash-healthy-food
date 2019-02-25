//
//  myOrdersVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/7/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class myOrdersVC: UIViewController {

    
    var myorder = [myorders]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewsss: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if helper.getAPIToken() != nil {
            viewsss.isHidden = true
        }else {
            viewsss.isHidden = false
        }
        
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
        API_Myorder.myorder{ (error: Error?, myorder: [myorders]?) in
            if let myorder = myorder {
                self.myorder = myorder
                print("xxx\(self.myorder)")
                self.tableView.reloadData()
            }
        }
        
    }
}


extension myOrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myorder.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as? myordersCell {
            let cartss = myorder[indexPath.item]
            cell.configuerCell(prodect: cartss)
            
            return cell
        }else {
            return myordersCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "suge", sender: myorder[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destaiantion = segue.destination as? myOrdersDetialsVC{
                if let sub = sender as? myorders{
                    destaiantion.singleItem = sub
                }
            }
        }
    }
