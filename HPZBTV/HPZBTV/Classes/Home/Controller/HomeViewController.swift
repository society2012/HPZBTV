//
//  HomeViewController.swift
//  HPZBTV
//
//  Created by hupeng on 17/3/21.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH :CGFloat = 40


class HomeViewController: UIViewController {

    
    /// <#Description#>
    fileprivate lazy var pageTitleView : ZBPageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigaitonBarH, width: kScreenW, height: kTitleViewH)
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = ZBPageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.orange
        titleView.delegate = self
        return titleView
        
    }()
    
    fileprivate lazy var pageContengView:PageContentView = {[weak self] in
    
        var childVCs = [UIViewController]()
        
        
        for _ in 0..<4{
            let vc = UIViewController()
            
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVCs.append(vc)
            
        }
        
        let contentH = kScreenH - kStatusBarH - kNavigaitonBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigaitonBarH + kTitleViewH, width: kScreenW, height: contentH)
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)

        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(self.pageTitleView)
        view.addSubview(pageContengView)
        pageContengView.delegate = self
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

extension HomeViewController:ZBPageTitleViewDelegate{

    func pageTitleView(pageView: ZBPageTitleView, selectIndex index: Int) {
        print(index)
        self.pageContengView.setCurrentIndex(currentIndex: index)
        
    }
}

extension HomeViewController:PageContentViewDelegate{
    func pageContentView(content: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        self.pageTitleView.setTitleViewProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

