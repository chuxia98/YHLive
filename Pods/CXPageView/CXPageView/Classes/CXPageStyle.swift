//
//  CXTitleStyle.swift
//  Pods
//
//  Created by mac on 2017/2/9.
//
//

import UIKit

public class CXPageStyle: NSObject {
    /// 是否是滚动的Title
    public var isScrollEnable : Bool = false
    
    public var titleViewHeight : CGFloat = 44
    public var itemMargin : CGFloat = 10

    public var titleFont : UIFont = UIFont.systemFont(ofSize: 14)

    public var titleViewBackgroundColor : UIColor = UIColor.clear
    public var contentViewBackgroundColor : UIColor = UIColor.clear
    
    public var selectedColor : UIColor = UIColor(r: 255, g: 127, b: 0)
    public var normalColor : UIColor = UIColor(r: 0, g: 0, b: 0)

    /// 是否显示底部滚动条
    public var isShowBottomLine : Bool = false
    /// 底部滚动条的颜色
    public var bottomLineColor : UIColor = UIColor.orange
    /// 底部滚动条的高度
    public var bottomLineH : CGFloat = 2

    /// 是否进行缩放
    public var isNeedScale : Bool = false
    public var scaleRange : CGFloat = 1.2

    /// 是否显示遮盖
    public var isShowCover : Bool = false
    /// 遮盖背景颜色
    public var coverBgColor : UIColor = UIColor.lightGray
    /// 文字&遮盖间隙
    public var coverMargin : CGFloat = 5
    /// 遮盖的高度
    public var coverH : CGFloat = 25
    /// 设置圆角大小
    public var coverRadius : CGFloat = 12
}
