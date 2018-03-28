//
//  NetworkTools.swift
//  Alamofire的测试
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools : NSObject {
    
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {

        let method = type == .get ? HTTPMethod.get : HTTPMethod.post

        Alamofire.request(URLString, method: method, parameters: parameters).validate(contentType: ["text/plain", "application/json"]).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            finishedCallback(result)
        }
    }
}

