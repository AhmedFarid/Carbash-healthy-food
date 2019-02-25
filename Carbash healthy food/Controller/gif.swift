//
//  gif.swift
//  Carbash healthy food
//
//  Created by farid on 2/24/19.
//  Copyright © 2019 farid. All rights reserved.
//

import UIKit

class gif: UIViewController {
    
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gifImageWithName("44")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(imageView)
        
        startTimer()
        
        
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 7.0,
                                     target: self,
                                     selector: #selector(eventWith(timer:)),
                                     userInfo: [ "foo" : "bar" ],
                                     repeats: false)
    }
    
    @objc func eventWith(timer: Timer!) {
        if helper.getAPIToken() == nil {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            var vc = UIViewController()
            vc = sb.instantiateViewController(withIdentifier: "x")
            self.present(vc, animated: true, completion: nil)
        }else {
            let sb = UIStoryboard(name: "home", bundle: nil)
            var vc = UIViewController()
            vc = sb.instantiateViewController(withIdentifier: "z")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func xx(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: nil)
    }
}
