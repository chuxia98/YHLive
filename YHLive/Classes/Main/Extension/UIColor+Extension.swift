//
//  UIColor+Extension.swift
//  YHLive
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 chuxia. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init?(hex : String, alpha : CGFloat = 1.0) {
        
        // 1.判断字符串长度是否符合
        guard hex.characters.count >= 6 else {
            return nil
        }
        
        // 2.将字符串转成大写
        var tempHex = hex.uppercased()
        
        // 3.判断开头 0x ##
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(to: 2)
        }
        
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(to: 1)
        }
        
        //
        var range = NSRange(location: 0, length: 2)
        let rHax = (tempHex as NSString).substring(with: range)
        
        range.location = 2
        let gHax = (tempHex as NSString).substring(with: range)
        
        range.location = 4
        let bHax = (tempHex as NSString).substring(with: range)
        
        // 
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHax).scanHexInt32(&r)
        Scanner(string: gHax).scanHexInt32(&g)
        Scanner(string: bHax).scanHexInt32(&b)
        
        self.init(r : CGFloat(r), g : CGFloat(g), b : CGFloat(b))
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
