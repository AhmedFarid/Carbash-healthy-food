//
//  mailDeatilesVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class mailDeatilesVC: UIViewController {
    
    var singleItem: homeMeals?
    var mailDetial = [mailDetials]()
    var count = 0
    var carts = [Cart]()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.text = singleItem?.name
        self.price.text = "\(singleItem?.price ?? "") ريال "
        
        self.image.image = UIImage(named: "3")
        let s = ("\(URLs.mainImage)\(singleItem?.image ?? "")")
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        
        self.image.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            self.image.kf.setImage(with: url)
            //imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "3"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        handleRefreshHomeMaill()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleRefresh()
    }
    
    
    @objc func handleRefresh() {
        API_Cart.cart{ (error: Error?, carts: [Cart]?) in
            if let carts = carts {
                self.carts = carts
                print("xxx\(self.carts)")
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[1]
                    tabItem.badgeValue = "\(carts.count)"
                }
            }
        }
    }

    
    @objc private func handleRefreshHomeMaill() {
        API_Home.homeMealdetails(category_id: singleItem?.id ?? ""){ (error: Error?, mailDetial: [mailDetials]?) in
            if let mailDetial = mailDetial {
                self.mailDetial = mailDetial
                print("xxx\(self.mailDetial)")
                self.tabelView.reloadData()
            }
        }
        
    }
    @IBAction func addToCart(_ sender: Any) {
        print("cc")
        API_Home.postCart(meal_foods_id: singleItem?.id ?? "") { (error: Error?, success: Bool, data) in
            if success {
                self.showAlert(title: "اضافة للسلة", message: data ?? "")
                self.handleRefresh()
            }else {
                
            }
        }
        
    }
}

extension mailDeatilesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailDetial.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? foodDetialsCell {
            let iamge = mailDetial[indexPath.item]
            cell.configuerCell(prodect: iamge)
            return cell
        }else {
            return foodDetialsCell()
        }
        
    }
}
