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
        var pressName:String
        var displayName:String
        var platform:TMPJAuth.ThirdPlatform
    }
    var info:Info
    {
        switch self
        {
        case .QQ:
            return Info(imageName: "login_platform_qq", pressName: "login_platform_qq", displayName: "QQ", platform: .qq);
        case .wechat:
            return Info(imageName: "login_platform_wechat", pressName: "login_platform_wechat", displayName: "微信", platform: .wechat);
        case .weibo:
            return Info(imageName: "login_platform_weibo", pressName: "login_platform_weibo", displayName: "微博", platform: .weibo);
        }
    }
}
final class TMPJOpenPlatform: OPOpenPlatform {
    static let shared = TMPJOpenPlatform();
    private override init()
    {
        super.init()
        self.setDebugEnable(true)
        self.configTencent(OPPlatformConfig(appid: "1106097003", appkey: "Z9YAvevgtnD6baII", schema: ""))
        self.configWechat(OPPlatformConfig(appid: "wxbec8708bc602a8d0", appkey: "9e1bf56e0dbb905e7fd35eda9b8fca47", schema: ""))
        let weibo = OPPlatformConfig(appid: "2588804445", appkey: "8d9c1674b6a6c6a0f6a8f6adcc97abec", schema: "wb2588804445")
        weibo.redirectURI = "http://www.icegent.com"
        self.configWeibo(weibo)
    }
}

