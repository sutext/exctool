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
let kTMPJStandardFont                 =   UIFont.systemFont(ofSize: ETScaledFloat(15));
let kTMPJSectionHeaderHeight:CGFloat  =   15;

let kTMPJGlobalConfig = TMPJGlobalConfig();
class TMPJGlobalConfig
{
    fileprivate init() {}
    
    func globalConfig()
    {
        let navbar = UINavigationBar.appearance();
        navbar.shadowImage = UIImage(color: UIColor.clear, size: CGSize(width: 1, height: 1));
        navbar.setBackgroundImage(UIImage(color: kTMPJThemeColor, size: CGSize(width: 1, height: 1)), for: .default);
        navbar.titleTextAttributes=[NSForegroundColorAttributeName:UIColor.white];
    }
}
