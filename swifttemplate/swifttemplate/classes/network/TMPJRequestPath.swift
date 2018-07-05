//
//  TMPJRequestPath.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit
struct TMPJRequestPath {
    let rawValue:String
    let simplekey:String
    private init(_ value:String,key:String = "simplekey"){
        self.rawValue = value
        self.simplekey = key
    }
}
extension TMPJRequestPath {
    static func auth(_ path:Auth)->TMPJRequestPath{
        switch path {
        default:
            return TMPJRequestPath(path.rawValue)
        }
        
    }
    static func third(_ path:Third)->TMPJRequestPath{
        return TMPJRequestPath(path.rawValue)
    }
    static func other(_ path:Other)->TMPJRequestPath{
        return TMPJRequestPath(path.rawValue)
    }
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
