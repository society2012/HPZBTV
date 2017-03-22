//
//  HomeViewController.swift
//  HPZBTV
//
//  Created by hupeng on 17/3/21.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }

}


extension HomeViewController{
    fileprivate func setupUI(){
        setupnNavigationBar()
    }
    
    private func setupnNavigationBar(){
        
        let logoItem = UIBarButtonItem(imageName: "logo")
        
        navigationItem.leftBarButtonItem = logoItem
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
}
