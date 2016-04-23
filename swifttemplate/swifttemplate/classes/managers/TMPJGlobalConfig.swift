//
//  TMPJGlobalConfig.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

let kTMPJThemeColor                   =   ETColorFromRGBA(0x00a2ca,0.99);
let kTMPJSeparatorColor               =   ETColorFromRGBA(0xe5e5e5,0.95);
let kTMPJFirstTextColor               =   ETColorFromRGB(0x000000);
let kTMPJSecendTextColor              =   ETColorFromRGB(0x939393);
let kTMPJBackgroundColor              =   ETColorFromRGB(0xf3f4f5);
let kTMPJStandardFont                 =   UIFont.systemFontOfSize(ETScaledFloat(15));
let kTMPJSectionHeaderHeight:CGFloat  =   15;

let kTMPJGlobalConfig = TMPJGlobalConfig();
class TMPJGlobalConfig
{
    private init() {}
    
    func globalConfig()
    {
        let navbar = UINavigationBar.appearance();
        navbar.shadowImage = UIImage(color: UIColor.clearColor(), size: CGSize(width: 1, height: 1));
        navbar.setBackgroundImage(UIImage(color: kTMPJThemeColor, size: CGSize(width: 1, height: 1)), forBarMetrics: .Default);
        navbar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.whiteColor()];
    }
}
