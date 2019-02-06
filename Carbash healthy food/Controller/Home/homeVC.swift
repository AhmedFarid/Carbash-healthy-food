//
//  homeVC.swift
//  Carbash healthy food
//
//  Created by farid on 1/30/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class homeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mainlcollection: UICollectionView!
    
    var images = [banners]()
    var homemail = [homeMeals]()
    
    var currentIndex = 0
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
        
        mainlcollection.delegate = self
        mainlcollection.dataSource = self
        
        
        handleRefreshHomeMaill()
        handleRefresh()
        bordercollection()
        customBackBtton()
    }
    
    @objc private func handleRefreshHomeMaill() {
        API_Home.homeMeal{ (error: Error?, homemail: [homeMeals]?) in
            if let homemail = homemail {
                self.homemail = homemail
                print("xxx\(self.homemail)")
                self.mainlcollection.reloadData()
            }
        }
        
    }
    
    @objc private func handleRefresh() {
        API_Home.banner{ (error: Error?, images: [banners]?) in
            if let images = images {
                self.images = images
                print("xxx\(self.images)")
                self.bannerCollection.reloadData()
                self.pageControl.numberOfPages = images.count
                self.startTimer()
            }
        }
        
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        
        let desiredScrollPosititon = (currentIndex < images.count - 1) ? currentIndex + 1 : 0
        bannerCollection.scrollToItem(at: IndexPath(item: desiredScrollPosititon, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func customBackBtton() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func bordercollection(){
        mainlcollection.layer.cornerRadius = 5.0
        mainlcollection.layer.borderWidth = 2.0
        mainlcollection.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    }
}

extension homeVC: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return images.count
        }else {
            return homemail.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell {
                let iamge = images[indexPath.item]
                cell.configuerCell(prodect: iamge)
                return cell
            }else {
                return BannerCell()
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? homeMaillcell{
                let iamge = homemail[indexPath.item]
                cell.configuerCell(prodect: iamge)
                return cell
            }else {
                return homeMaillcell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            print("0")
        }else {
            performSegue(withIdentifier: "suge2", sender: homemail[indexPath.row])
            print("no")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? mailDeatilesVC{
            if let sub = sender as? homeMeals{
                destaiantion.singleItem = sub
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }else {
            let screenWidth = collectionView.frame.width
            
            var width = (screenWidth-30)/2
            
            width = width < 130 ? 160 : width
            
            return CGSize.init(width: width, height: width)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if bannerCollection.tag == 0 {
            currentIndex = Int(scrollView.contentOffset.x / bannerCollection.frame.size.width)
            pageControl.currentPage = currentIndex
        }
    }
    
}



