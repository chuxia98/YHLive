//
//  RoomViewController.swift
//  YHLive
//
//  Created by chen on 2018/3/22.
//  Copyright © 2018年 chuxia. All rights reserved.
//

import UIKit
import IJKMediaFramework
import Alamofire

class RoomViewController: UIViewController {
    @IBOutlet weak var bgImageView: UIImageView!

//    fileprivate lazy var chatToolsView : ChatToolsView = ChatToolsView.loadFromNib()
//    fileprivate lazy var giftListView : GiftListView = GiftListView.loadFromNib()
//    fileprivate lazy var chatContentView : ChatContentView = ChatContentView.loadFromNib()

    var anchor : AnchorModel?
    fileprivate var ijkPlayer : IJKFFMoviePlayerController?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadAnchorLiveAddress()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.isStatusBarHidden = true;
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.isStatusBarHidden = false;
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ijkPlayer?.shutdown()
    }
}

extension RoomViewController {
    fileprivate func loadAnchorLiveAddress() {

        // 1.获取请求的地址
        let urlString = "http://qf.56.com/play/v2/preLoading.ios"

        // 2.获取请求的参数
        let parameters : [String : Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056", "signature" : "f69f4d7d2feb3840f9294179cbcb913f", "roomId" : anchor!.roomid, "userId" : anchor!.uid]

        NetworkTools.requestData(.get, URLString: urlString, parameters: parameters) { (result) in
            print("anchor info --- \n \(result)")

            // 1.将result转成字典类型
            let resultDict = result as? [String : Any]

            // 2.从字典中取出数据
            let infoDict = resultDict?["message"] as? [String : Any]

            // 3.获取请求直播地址的URL
            guard let rURL = infoDict?["rUrl"] as? String else { return }

            // 4.请求直播地址
            NetworkTools.requestData(.get, URLString: rURL, finishedCallback: { (result) in
                print("live address \n \(result)")
                let resultDict = result as? [String : Any]
                let liveURLString = resultDict?["url"] as? String
                self.displayLiveView(liveURLString)
            })
        }
    }

    fileprivate func displayLiveView(_ liveURLString : String?) {
        // 1.获取直播的地址
        guard let liveURLString = liveURLString else {
            return
        }

        // 2.使用IJKPlayer播放视频
        let options = IJKFFOptions.byDefault()
        options?.setOptionIntValue(1, forKey: "videotoolbox", of: kIJKFFOptionCategoryPlayer)
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: liveURLString, with: options)

        // 3.设置frame以及添加到其他View中
        if anchor?.push == 1 {
            ijkPlayer?.view.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: bgImageView.bounds.width, height: bgImageView.bounds.width * 3 / 4))
            ijkPlayer?.view.center = bgImageView.center
        } else {
            ijkPlayer?.view.frame = bgImageView.bounds
        }

        print("bounds:", bgImageView.bounds)

        bgImageView.addSubview(ijkPlayer!.view)
        ijkPlayer?.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        // 4.开始播放
        ijkPlayer?.prepareToPlay()
    }

}

extension RoomViewController {
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
}
