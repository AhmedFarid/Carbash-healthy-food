//
//  myPackagesVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/11/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class myPackagesVC: UIViewController {
    
    var package = [packages]()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var delivared: UILabel!
    @IBOutlet weak var onWay: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var notSubscribe: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        if self.package.count == 0{
            self.notSubscribe.isHidden = false
            self.image.isHidden = true
            self.total.isHidden = true
            self.delivared.isHidden = true
            self.onWay.isHidden = true
            self.tabelView.isHidden = true
            self.name.isHidden = true
            self.cancelBtn.isHidden = true
        }
        
        getDat()
    }
    
    func getDat() {
        API_Package.getSubscribe{(error: Error?, success: Bool, package: [packages]?,period,packageName,wait,arrived,image)  in
            if success {
                if let package = package {
                    self.package = package
                    print("xxx\(self.package)")
                    if self.package.count == 0{
                        self.notSubscribe.isHidden = false
                        self.image.isHidden = true
                        self.total.isHidden = true
                        self.delivared.isHidden = true
                        self.onWay.isHidden = true
                        self.tabelView.isHidden = true
                        self.name.isHidden = true
                        self.cancelBtn.isHidden = true
                        
                    } else {
                        
                        self.notSubscribe.isHidden = true
                        self.image.isHidden = false
                        self.total.isHidden = false
                        self.delivared.isHidden = false
                        self.onWay.isHidden = false
                        self.tabelView.isHidden = false
                        self.name.isHidden = false
                        self.cancelBtn.isHidden = false
                        
                        self.total.text = "سعة الاشتراك\n\(period ?? 0)"
                        self.delivared.text = "تم التوصيل\n\(arrived ?? 0)"
                        self.onWay.text = "في الطريق\n\(wait ?? 0)"
                        self.name.text = packageName
                        
                        self.image.image = UIImage(named: "3")
                        let s = ("\(URLs.mainImage)/\(image ?? "")")
                        print(s)
                        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
                        let encodedURL = NSURL(string: encodedLink!)! as URL
                        
                        self.image.kf.indicatorType = .activity
                        if let url = URL(string: "\(encodedURL)") {
                            print("g\(url)")
                            self.image.kf.setImage(with: url)
                            //imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "3"), options: nil, progressBlock: nil, completionHandler: nil)
                            
                        }
                        self.tabelView.reloadData()
                        
                    }
                    
                }
            }else {
                print("error")
            }
            
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
    }
}

extension myPackagesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return package.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? myBakageCell {
            let cartss = package[indexPath.item]
            cell.configuerCell(prodect: cartss)
            
            return cell
        }else {
            return myBakageCell()
            
        }
    }
    
}
