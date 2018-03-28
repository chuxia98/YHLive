//
//  CXNavigationController.swift
//  YHLive
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 chuxia. All rights reserved.
//

import UIKit

class CXNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
