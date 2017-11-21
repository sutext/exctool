//
//  TMPJButton.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJButton: AMButton {
    override init(frame: CGRect, style: AMButton.TitleStyle) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}
extension TMPJButton{
    class func cover(title:String,
                     size:CGSize,
                     titleColor:UIColor? = .mainText,
                     titleFont:UIFont? = .size14,
                     imageColor:UIColor? = .white,
                     cornerRadius:CGFloat = 0) ->TMPJButton
    {
        let button = TMPJButton(.cover);
        let item = AMButtonItem();
        item.title = title;
        item.titleFont = titleFont;
        item.titleColor = titleColor;
        item.imageSize = size;
        item.imageColor = imageColor;
        item.cornerRadius = cornerRadius;
        button.apply(item:item, for: .normal);
        button.sizeToFit();
        return button;
    }
    
    class func cover(imageName:String,pressName:String?=nil,size:CGSize)->TMPJButton
    {
        let loginButton = TMPJButton(.cover);
        let loginItem = AMButtonItem();
        loginItem.imageSize = size;
        loginItem.image = UIImage(named: imageName);
        loginButton.apply(item:loginItem, for: .normal);
        if let pressimg = pressName
        {
            loginButton.setImage(UIImage(named: pressimg), for: .highlighted);
        }
        loginButton.sizeToFit();
        return loginButton;
    }
    class func bottom(imageName:String,
                      pressName:String?=nil,
                      title:String,
                      imageSize:CGSize,
                      titleFont:UIFont = .size12,
                      titleColor:UIColor = .mainText,
                      pressColor:UIColor?=nil) ->TMPJButton
    {
        let button = TMPJButton(.bottom);
        let item = AMButtonItem();
        item.title = title;
        item.titleFont = titleFont;
        item.titleColor = titleColor;
        item.imageSize = imageSize;
        item.image = UIImage(named: imageName);
        button.titleEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0);
        button.apply(item:item, for: .normal);
        if let pressName = pressName {
            button.setImage(UIImage(named: pressName), for: .highlighted);
        }
        if let color = pressColor{
            button.setTitleColor(color, for: .highlighted)
        }
        button.sizeToFit();
        return button;
    }
}
extension TMPJButton{
    enum ThemType {
        case hollow
        case fill
    }
    class func theme(_ type:ThemType,
                     title:String,
                     size:CGSize,
                     font:UIFont = .size14,
                     cornerRadius:CGFloat?=nil)->TMPJButton
    {
        let button = TMPJButton(.cover)
        let item = AMButtonItem()
        item.title = title
        item.titleFont = font
        item.imageSize = size
        if let radius = cornerRadius {
            item.cornerRadius = radius
        }
        else{
            item.cornerRadius = size.height/2
        }
        switch type {
        case .hollow:
            item.titleColor = .theme
            item.imageColor = .white
            button.setTitleColor(.white, for: .highlighted)
            button.setImage(UIImage(color:.theme,size:size), for: .highlighted)
            button.setTitleColor(.white, for: .selected)
            button.setImage(.gradual(from: UIColor(0xd33a31), to: UIColor(0x9f3029), size: size), for: .selected)
            button.adjustsImageWhenHighlighted = false
            button.layer.borderColor = UIColor.theme.cgColor
            button.layer.borderWidth  = 1;
        case .fill:
            item.titleColor = .white
            item.image = .gradual(from: UIColor(0xd33a31), to: UIColor(0x9f3029), size: size)
        }
        button.apply(item:item, for: .normal);
        button.sizeToFit();
        return button;
    }
}
