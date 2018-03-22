//
//  CXPageView.swift
//  pageView
//
//  Created by mac on 2016/12/22.
//  Copyright © 2016年 chuxia. All rights reserved.
//

import UIKit

public class CXPageView: UIView {

    fileprivate var titles : [String]
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVC : UIViewController
    fileprivate var style : CXPageStyle

    fileprivate var titleView : CXTitleView!
    fileprivate var contentView : CXContentView!
    
    public init(_ frame: CGRect, _ titles: [String], _ childVcs: [UIViewController], _ parentVC : UIViewController, _ style : CXPageStyle) {

        assert(titles.count == childVcs.count, "标题&控制器个数不同,请检测!!!")

        self.titles = titles
        self.childVcs = childVcs
        self.parentVC = parentVC
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CXPageView {
    fileprivate func setupUI() {
        setupTitleView()
        setupContentView()
    }
    
    private func setupTitleView() {
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleViewHeight)
        titleView = CXTitleView(frame, titles, style)
        titleView.backgroundColor = style.titleViewBackgroundColor
        titleView.delegate = self
        addSubview(titleView)
    }
    
    private func setupContentView() {
        let frame = CGRect(x: 0, y: style.titleViewHeight, width: bounds.width, height: bounds.height - style.titleViewHeight)
        contentView = CXContentView(frame, childVcs, parentVC)
        contentView.backgroundColor = style.contentViewBackgroundColor
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}

extension CXPageView : CXTitleViewDelegate {
    public func titleView(_ titleView: CXTitleView, currentIndex: Int) {
        contentView.setCurrentIndex(currentIndex)
    }
}

extension CXPageView : CXContentViewDelegate {
    public func contentView(_ contentView: CXContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }

    public func contentViewEndScroll(_ contentView: CXContentView) {
        titleView.contentViewDidEndScroll()
    }
}
