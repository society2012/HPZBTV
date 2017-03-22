//
//  UIBarbuttonItem_extension.swift
//  HPZBTV
//
//  Created by hupeng on 17/3/22.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
    class func creatItem(imageName:String,hightImageName:String,size:CGSize) ->UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin:  CGPoint(x: 0, y: 0), size: size)
        let item = UIBarButtonItem(customView: btn)
        return item
    }
    
    //便利构造函数
    convenience init(imageName:String,hightImageName:String = "",size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        if hightImageName != ""{
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        btn.setImage(UIImage(named: imageName), for: .normal)
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin:  CGPoint.zero, size: size)
        }
        self.init(customView:btn)
        
    }
    
}


