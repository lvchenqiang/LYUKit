//
//  Data+APNSToken.swift
//  LYUKit
//
//  Created by 吕陈强 on 2018/12/12.
//  Copyright © 2018 吕陈强. All rights reserved.
//

import Foundation
extension Data
{
    /**
     *  @brief  将APNS NSData类型token 格式化成字符串
     *
     *  @return 字符串token
     */
    var APNSToken:String{
        get{
            return self.description.replacingOccurrences(of: "<", with: "")
            .replacingOccurrences(of: ">", with: "")
            .replacingOccurrences(of: " ", with: "")
        }
    }
}
