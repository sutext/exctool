//
//  TMPJOpenPlatform.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import OpenPlatform
extension OPPlatformError:Error,TMPJAlertable
{
    var message: String{
        switch self {
        case .cancel:
            return "用户已取消"
        case .exception:
            return "第三方数据异常"
        case .network:
            return "网络不给力"
        case .notInstall:
            return "APP未安装"
        case .unsuport:
            return "版本不支持"
        case .refuse:
            return "用户已拒绝"
        case .succeed:
            return "操作成功"
        default:
            return "其他错误"
        }
    }
}
extension OPOpenShareType
{
    var info:(image:String,title:String,appname:String)
    {
        switch self
        {
        case .QQ:
            return ("share_qq","QQ","QQ");
        case .qqZone:
            return ("share_qqzone","QQ空间","QQ");
        case .wechat:
            return ("share_wechat","微信","微信");
        case .moments:
            return ("share_moments","朋友圈","微信");
        default:
            return ("","","");
        }
    }
}
extension OPOpenAuthType
{
    struct Info {
        var imageName:String
        var pressName:String?
        var displayName:String
        var platform:TMPJAuth.ThirdPlatform
        init(imageName:String="",pressName:String?=nil,displayName:String="",platform:TMPJAuth.ThirdPlatform = .qq) {
            self.imageName = imageName
            self.pressName = pressName
            self.displayName = displayName
            self.platform = platform
        }
    }
    var info:Info
    {
        switch self
        {
        case .QQ:
            return Info(imageName: "login_platform_qq", displayName: "QQ", platform: .qq);
        case .wechat:
            return Info(imageName: "login_platform_wechat", displayName: "微信", platform: .wechat);
        case .weibo:
            return Info(imageName: "login_platform_weibo", displayName: "微博", platform: .weibo);
        }
    }
}
final class TMPJOpenPlatform: OPOpenPlatform {
    static let shared = TMPJOpenPlatform();
    private override init()
    {
        super.init()
        self.setDebugEnable(global.isDebug)
        self.configAlipay("2017111309901611", schema: "playmate")
        self.configTencent("1106450111", appkey: "9KxsJHnzl1ppqST8")
        self.configWechat("wxe497443d905724b1", appkey: "bb173c71b7502f9d9229d80affffc0d6")
    }
}

