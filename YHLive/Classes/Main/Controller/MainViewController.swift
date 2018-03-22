//
//  MainViewController.swift
//  YHLive
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 chuxia. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc("Home")
        addChildVc("Rank")
        addChildVc("Discover")
        addChildVc("Profile")

        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        UIApplication.shared.isStatusBarHidden = false;
        self.tabBar.tintColor = UIColor.orange
    }

    fileprivate func addChildVc(_ storyName : String) {
        // 1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        // 2.将childVc作为子控制器
        addChildViewController(childVc)
    }

}
