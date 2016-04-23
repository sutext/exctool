//
//  OPOpenPlatform.swift
//  swifttemplate
//
//  Created by supertext on 16/2/22.
//  Copyright © 2016年 icegent. All rights reserved.
//

import OpenPlatform

extension OPOpenShareType
{
    var info:(image:String,title:String,appname:String)
        {
        get {
            switch self
            {
            case .QQ:
                return ("share_qq","QQ","QQ");
            case .QQZone:
                return ("share_qqzone","QQ空间","QQ");
            case .Weixin:
                return ("share_wechat","微信","微信");
            case .Moments:
                return ("share_moments","朋友圈","微信");
            default:
                return ("","","");
            }
        }
    }
}
let kTMPJOpenPlatform = TMPJOpenPlatform();
final class TMPJOpenPlatform: OPOpenPlatform {
    private override init()
    {
        super.init();
        self.configTencent(OPPlatformConfig(appid: "1105177744", appkey: "J9dgbdu4A4N8BitS", schema: ""));
        self.configWeixin(OPPlatformConfig(appid: "wx2be82b2e95313536", appkey: "d002282ecfcc88358adb713b1110d336", schema: ""))
    }
}
