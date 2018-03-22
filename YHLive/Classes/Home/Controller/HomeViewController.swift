//
//  HomeViewController.swift
//  YHLive
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 chuxia. All rights reserved.
//

import UIKit
import CXPageView

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = UIColor.white
    }

}

extension HomeViewController {
    
    fileprivate func setupUI() {
        setNavigationBar()
        setPageView()
    }

    fileprivate func loadTypesData() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var tempArray = [HomeType]()
        for dict in dataArray {
            tempArray.append(HomeType(dict: dict))
        }
        return tempArray
    }

    private func setPageView() {
        let homeTypes = loadTypesData()

        let frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height)
        let titles = homeTypes.map({ $0.title })
        var childVcs = [AnchorViewController]()
        for type in homeTypes {
            let vc = AnchorViewController()
            vc.homeType = type
            childVcs.append(vc)
        }
        let style = CXPageStyle()
        style.isScrollEnable = true
        style.contentViewBackgroundColor = UIColor.white
        let pageView = CXPageView(frame, titles, childVcs, self, style)
        self.view .addSubview(pageView)
    }
    
    private func setNavigationBar() {
        let logoImage = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)

        let collectImage = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImage, style: .plain, target: self, action: #selector(HomeViewController.followItemClick))
        
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.placeholder = "主播昵称/房间号/链接"
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .minimal
        let searchFiled = searchBar.value(forKey: "_searchField") as? UITextField
        searchFiled?.textColor = UIColor.white
    }
}

extension HomeViewController {
    @objc fileprivate func followItemClick() {
        print("---")
    }
}
