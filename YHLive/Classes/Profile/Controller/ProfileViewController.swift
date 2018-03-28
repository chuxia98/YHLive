//
//  ProfileViewController.swift
//  YHLive
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 chuxia. All rights reserved.
//

import UIKit
import LFLiveKit

class ProfileViewController: UIViewController {

    lazy var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .low2, outputImageOrientation: UIInterfaceOrientation.portrait)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        session?.preView = self.view
        return session!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startOutput(_ sender: Any) {
        let stream = LFLiveStreamInfo()
        stream.url = "rtmp://50.110.27.24/live/demo";
        session.startLive(stream)
        session.running = true
    }
    
}
