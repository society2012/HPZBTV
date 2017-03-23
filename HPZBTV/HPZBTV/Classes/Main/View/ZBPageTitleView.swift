//
//  ZBPageTitleView.swift
//  HPZBTV
//
//  Created by hupeng on 17/3/22.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

import UIKit




// MARK:-协议
protocol ZBPageTitleViewDelegate : class {
    func pageTitleView(pageView:ZBPageTitleView , selectIndex index :Int)
}
// MARK:-常量

//元组
fileprivate let kNormalColour :(CGFloat,CGFloat,CGFloat) = (85,85,85)

fileprivate let kSelectColour :(CGFloat,CGFloat,CGFloat) = (255,128,0)

fileprivate let kScroviewLineH:CGFloat = 2

class ZBPageTitleView: UIView {
    
    fileprivate var titles :[String]
    fileprivate var currentIndex :Int = 0
    weak var delegate : ZBPageTitleViewDelegate?
    
    
    fileprivate lazy var titlesLabels: [UILabel] = [UILabel]()
    
    fileprivate lazy var scrowView : UIScrollView = {
        let scroView = UIScrollView()
        scroView.showsHorizontalScrollIndicator = false
        scroView.scrollsToTop = false
        scroView.bounces = false
        scroView.backgroundColor = UIColor.white
        return scroView
        
    }()
    
   fileprivate lazy var scorviewLine:UIView = {
        let scroViewLine = UIView()
        scroViewLine.backgroundColor = UIColor.orange
        return scroViewLine
    }()
    
    // MARK:-定义构成函数
    init(frame:CGRect , titles:[String]){
        self.titles = titles
        super.init(frame: frame)
        setupUI()
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}


extension ZBPageTitleView{
    fileprivate func setupUI(){
        addSubview(scrowView)
        scrowView.frame = self.bounds
        setupTitleLabels()
        setupBottonMenuLine()
        scrowView.addSubview(scorviewLine)
    }

    func setupTitleLabels(){
        let labelW : CGFloat = self.frame.width/CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScroviewLineH
        let labelY : CGFloat = 0
        for (index , title) in self.titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16)
            label.tag = index
            label.textColor = UIColor(r: kNormalColour.0, g: kNormalColour.1, b: kNormalColour.2)
            label.isUserInteractionEnabled = true
            label.textAlignment = .center
           let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrowView.addSubview(label)
            
            titlesLabels.append(label)
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector (self.titleLabelClick(tap:)))
            
            label.addGestureRecognizer(tap)
            
            
        }
    }
    func setupBottonMenuLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor  = UIColor.lightGray
        
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titlesLabels.first else{return}
        firstLabel.textColor = UIColor.orange
        
        scrowView.addSubview(scorviewLine)
        
        scorviewLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScroviewLineH, width: firstLabel.frame.width, height: kScroviewLineH)
    }
    
}

// MARK:-label 点击
extension ZBPageTitleView{
    @objc fileprivate func titleLabelClick(tap:UITapGestureRecognizer){
        
        guard let currentLabel = tap.view as? UILabel else{return}
        
        let oldLabel = self.titlesLabels[currentIndex]
        
        currentIndex = currentLabel.tag
        
        
        
        currentLabel.textColor = UIColor(r: kSelectColour.0, g: kSelectColour.1, b: kSelectColour.2)
        
        oldLabel.textColor = UIColor(r: kNormalColour.0, g: kNormalColour.1, b: kNormalColour.2)
        
        
        let scrollinePositionX = CGFloat(currentLabel.tag) * scorviewLine.frame.width
        
        UIView.animate(withDuration: 0.15){
            self.scorviewLine.frame.origin.x = scrollinePositionX
        }
        
        delegate?.pageTitleView(pageView: self, selectIndex: currentIndex)
        
        
    }
    
}




extension ZBPageTitleView{
    func setTitleViewProgress(progress:CGFloat, sourceIndex:Int , targetIndex:Int){
        let sourceLabel = self.titlesLabels[sourceIndex]
        let targetLabel = self.titlesLabels[targetIndex]

      let moveTotalX =  targetLabel.frame.origin.x - sourceLabel.frame.origin.x
       let moveX = moveTotalX * progress
        scorviewLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        let colourDelta = (kSelectColour.0 - kNormalColour.0,kSelectColour.1 - kNormalColour.1,kSelectColour.2 - kNormalColour.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColour.0 - colourDelta.0 * progress, g: kSelectColour.1 - colourDelta.1 * progress, b: kSelectColour.2 - colourDelta.2 * progress)
        
         targetLabel.textColor = UIColor(r: kNormalColour.0 +  colourDelta.0 * progress, g: kNormalColour.1 + colourDelta.1 * progress, b: kNormalColour.2 + colourDelta.2 * progress)
        currentIndex = targetIndex
        print("--------\(currentIndex)")
    }
}

