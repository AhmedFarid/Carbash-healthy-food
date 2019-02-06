//
//  PackagesVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//  suge

import UIKit

class PackagesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customBackBtton()
    }
    
    func customBackBtton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func a1(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: "a1")
    }
    
    
    @IBAction func a2(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: "a2")
    }
    
    
    @IBAction func a3(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: "a3")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? detailsPackagesVC{
            destaiantion.type = sender as! String 
            
        }
    }
    
}
