//
//  PageContentView.swift
//  HPZBTV
//
//  Created by hupeng on 17/3/22.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate : class {
    func pageContentView(content:PageContentView , progress:CGFloat, sourceIndex:Int, targetIndex:Int)
}


fileprivate let ContentCellId = "ContentCellId"

class PageContentView: UIView {
    
    fileprivate var startContentOffsetX:CGFloat = 0
    fileprivate var childerVCs:[UIViewController]
    fileprivate weak var parentViewController :UIViewController?
    weak var delegate: PageContentViewDelegate?
    fileprivate var isForbit:Bool = false
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
    
        let layOut = UICollectionViewFlowLayout()
        layOut.itemSize = (self?.bounds.size)!
        layOut.minimumLineSpacing = 0
        layOut.minimumInteritemSpacing = 0
        layOut.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layOut)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        
        return collectionView
        
    }()
    
    init(frame:CGRect , childVCs :[UIViewController],parentViewController:UIViewController?){
        
        self.childerVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageContentView{
    fileprivate func setupUI(){
        for childVC in childerVCs{
            parentViewController?.addChildViewController(childVC)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}



extension PageContentView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childerVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVC = self.childerVCs[indexPath.item]
        
        childVC.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}


extension PageContentView:UICollectionViewDelegate,UIScrollViewDelegate{
  
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbit = false
        
        startContentOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbit {return}
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scroViewW = scrollView.bounds.width
        //左
        if currentOffsetX > startContentOffsetX{
        
            progress = currentOffsetX / scroViewW - floor(currentOffsetX / scroViewW)
        
            sourceIndex = Int(currentOffsetX / scroViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childerVCs.count{
                targetIndex = targetIndex - 1
            }
            if currentOffsetX - startContentOffsetX == scroViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            progress = 1 - (currentOffsetX / scroViewW - floor(currentOffsetX / scroViewW))
            
            targetIndex = Int(currentOffsetX / scroViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childerVCs.count{
                sourceIndex = sourceIndex - 1
            }
  
        }
        print("progress \(progress)----\(targetIndex)---\(sourceIndex)")
        
        delegate?.pageContentView(content: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)

    }
    
    
}

extension PageContentView{

   open func setCurrentIndex(currentIndex: Int){
    isForbit = true
        let offsetX = CGFloat(currentIndex) * self.collectionView.frame.size.width
//        CGPoint point = CGPoint(x: offsetX, y: collectionView.frame.origin.y)
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: collectionView.frame.origin.y), animated: true)
        
    }
}


