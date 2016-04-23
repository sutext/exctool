//
//  TMPJImageViewCell.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJImageViewCell: TMPJTableViewCell {
    lazy var iconView:TMPJImageView = {
        var icon = TMPJImageView(frame:CGRect(x: 10,y: 10,width: 60,height: 60));
        self.contentView.addSubview(icon);
        return icon;
    }()
}
