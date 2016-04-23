//
//  TMPJButton.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJButton: ETButton {
    class func createButton(title:String,titleColor:UIColor?,titleFont:UIFont?,width:CGFloat,height:CGFloat,backgoundColor:UIColor?,cornerRadius:CGFloat) ->TMPJButton
    {
        let button = TMPJButton(style:.Cover);
        let item = ETButtonItem();
        item.title = title;
        item.titleFont = titleFont;
        item.titleColor = titleColor;
        item.imageSize = CGSize(width: width, height: height);
        item.imageColor = backgoundColor;
        item.cornerRadius = cornerRadius;
        button.applyButtonItem(item, forState: .Normal);
        button.sizeToFit();
        return button;
    }
    class func actionButton(title:String,titleColor:UIColor) ->TMPJButton
    {
        return self.createButton(title, titleColor: titleColor, titleFont: UIFont.systemFontOfSize(17), width: ETScreenWidth(), height: 50, backgoundColor: UIColor.whiteColor(), cornerRadius: 0);
    }
    class func actionButton(title:String,width:CGFloat) ->TMPJButton
    {
        return self.createButton(title, titleColor: UIColor.blackColor(), titleFont: UIFont.systemFontOfSize(17), width: width, height: 50, backgoundColor: UIColor.whiteColor(), cornerRadius: 0);
    }

}
