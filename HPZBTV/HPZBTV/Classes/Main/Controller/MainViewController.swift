//
//  MainViewController.swift
//  HPZBTV
//
//  Created by hupeng on 17/3/21.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

import UIKit


class MainViewController: UITabBarController {

     
    override func viewDidLoad() {
        super.viewDidLoad()
        //storebord 箭头所指的控制器
        addChildVC(storeName: "Home");
        addChildVC(storeName: "Live");
        addChildVC(storeName: "Follow");
        addChildVC(storeName: "Profile");

        // Do any additional setup after loading the view.
    }
    
    
    
    private func addChildVC(storeName:String){
        let childVC = UIStoryboard(name: storeName, bundle: nil).instantiateInitialViewController()!
        
        
        self.addChildViewController(childVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
