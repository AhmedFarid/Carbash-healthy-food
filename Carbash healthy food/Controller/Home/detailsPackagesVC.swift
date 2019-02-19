//
//  detailsPackagesVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class detailsPackagesVC: UIViewController {

    var type = ""
    var id = ""
    var banners = [backageBanner]()
    
    
    
    @IBOutlet weak var sliderCollection: UICollectionView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var schudel: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentIndex = 0
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        
        print(type)
        getDat()
        customBackBtton()
    }
    
    func customBackBtton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    func getDat() {
        API_Home.detailsPackage (type: type) {(error: Error?, success: Bool, banners: [backageBanner]?,id,name,price,type,description)  in
            if success {
                if let banners = banners {
                    self.banners = banners
                    print("xxx\(self.banners)")
                    self.sliderCollection.reloadData()
                    self.pageControl.numberOfPages = banners.count
                    self.startTimer()
                    self.name.text = name
                    self.price.text = "\(price ?? "") ريال "
                    self.schudel.text = type
                    self.des.text = "\(description ?? "")"
                    self.id = id ?? ""
                }
            }else {
                print("error")
            }
            
        }
    }
    
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        
        let desiredScrollPosititon = (currentIndex < banners.count - 1) ? currentIndex + 1 : 0
        sliderCollection.scrollToItem(at: IndexPath(item: desiredScrollPosititon, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    @IBAction func subbutton(_ sender: Any) {
        API_Package.subscribe(package_id: id){ (error: Error?, success: Bool, data) in
            if success {
                self.showAlert(title: "اشتراك", message: data ?? "")
            }else {
                
            }
        }
    }
    
}

extension detailsPackagesVC: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? backageBanners {
            let iamge = banners[indexPath.item]
            cell.configuerCell(prodect: iamge)
            return cell
        }else {
            return backageBanners()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            currentIndex = Int(scrollView.contentOffset.x / sliderCollection.frame.size.width)
            pageControl.currentPage = currentIndex
    }
    
}




