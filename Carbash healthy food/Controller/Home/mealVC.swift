//
//  mealVC.swift
//  Carbash healthy food
//
//  Created by farid on 2/3/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class mealVC: UIViewController {

    @IBOutlet weak var tabelView: UICollectionView!
    
    var homemail = [homeMeals]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        handleRefreshHomeMaill()
    }
    
    @objc private func handleRefreshHomeMaill() {
        API_Home.homeMeal{ (error: Error?, homemail: [homeMeals]?) in
            if let homemail = homemail {
                self.homemail = homemail
                print("xxx\(self.homemail)")
                self.tabelView.reloadData()
            }
        }
        
    }
}

extension mealVC: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return homemail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? homeMaillcell{
            let iamge = homemail[indexPath.item]
            cell.configuerCell(prodect: iamge)
            return cell
        }else {
            return homeMaillcell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "suge", sender: homemail[indexPath.row])
            print("no")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? mailDeatilesVC{
            if let sub = sender as? homeMeals{
                destaiantion.singleItem = sub
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = collectionView.frame.width
            
            var width = (screenWidth-30)/2
            
            width = width < 130 ? 160 : width
            
            return CGSize.init(width: width, height: width)
    }
    
}



