//
//  HomeViewController.swift
//  YHLive
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 chuxia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        view.backgroundColor = UIColor.randomColor()
    }

}

extension HomeViewController {
    
    fileprivate func setupUI() {
        setNavigationBar()
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
