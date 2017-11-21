//
//  TMPJRequestPath.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit

enum TMPJRequestPath {
    case auth(Auth)
    case third(Third)
    case other(Other)
}
extension TMPJRequestPath{
    enum Auth:String {
        case login          = "auth/login"
        case third          = "auth/third/login"
        case logout         = "auth/logout"
        case register       = "auth/register"
        case sendCode       = "auth/code/send"
        case verifyCode     = "auth/code/verify"
        case resetpwd       = "auth/password/reset"
    }
    enum Third:String {
        case list           = "auth/third/list"
        case add            = "auth/third/add"
        case delete         = "auth/third/del"
    }
    enum Other:String{
        case areaList       = "address/list"
        case area           = "address/detail"
    }
}
extension TMPJRequestPath:RawRepresentable{
    
    init?(rawValue: String) {
        return nil
    }
    var rawValue: String{
        switch self {
        case .auth(let type):
            return type.rawValue
        case .third(let type):
            return type.rawValue
        case .other(let type):
            return type.rawValue
        }
    }
}
