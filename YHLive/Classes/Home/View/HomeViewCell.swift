//
//  HomeViewCell.swift
//  YHLive
//
//  Created by chen on 2018/3/22.
//  Copyright © 2018年 chuxia. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleLabel: UIButton!

    var anchorModel : AnchorModel? {
        didSet {
            albumImageView.setImage(anchorModel!.isEvenIndex ? anchorModel?.pic74 : anchorModel?.pic51, "home_pic_default")
            liveImageView.isHidden = anchorModel?.live == 0
            nickNameLabel.text = anchorModel?.name
            onlinePeopleLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
        }
    }

}
