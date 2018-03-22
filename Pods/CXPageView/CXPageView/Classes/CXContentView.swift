//
//  CXContentVIew.swift
//  pageView
//
//  Created by mac on 2016/12/22.
//  Copyright © 2016年 chuxia. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

public protocol CXContentViewDelegate : class {
    func contentView(_ contentView : CXContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
    func contentViewEndScroll(_ contentView : CXContentView)
}

public class CXContentView: UIView {

    weak var delegate : CXContentViewDelegate?

    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentVC : UIViewController!
    fileprivate var isForbidScrollDelegate : Bool = false
    fileprivate var startOffsetX : CGFloat = 0
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = CXContentLayout()
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    public init(_ frame: CGRect, _ controllers: [UIViewController], _ parentVC : UIViewController) {
        self.childVcs = controllers
        self.parentVC = parentVC
        
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CXContentView {
    fileprivate func setupUI() {
        for vc in childVcs {
            parentVC.addChildViewController(vc)
        }
        addSubview(collectionView)
    }
}

extension CXContentView : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension CXContentView : UICollectionViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }

        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0

        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)

            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)

            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }

            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))

            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)

            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }

        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.contentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }


    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.contentViewEndScroll(self)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.contentViewEndScroll(self)
        }
    }
}

public extension CXContentView {
    public func setCurrentIndex(_ index: Int) {
        isForbidScrollDelegate = true

        let indexPath : IndexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

class CXContentLayout: UICollectionViewFlowLayout {
    override func prepare() {
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.scrollDirection = .horizontal
        self.itemSize = (collectionView?.bounds.size)!
    }
}
