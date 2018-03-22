//
//  BaseModel.swift
//  YHLive
//
//  Created by chen on 2018/3/22.
//  Copyright © 2018年 chuxia. All rights reserved.
//

import UIKit

class BaseModel : NSObject {
    override init() {

    }

    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
