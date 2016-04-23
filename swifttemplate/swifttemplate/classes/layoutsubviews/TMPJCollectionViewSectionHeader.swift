//
//  TMPJCollectionViewSectionHeader.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJCollectionViewSectionHeader: UICollectionReusableView {
    lazy var imageView:TMPJImageView = {
        var image = TMPJImageView(frame:self.bounds);
        self.addSubview(image);
        return image;
    }()
    lazy var textLabel:TMPJLabel = {
        var label = TMPJLabel(frame:self.bounds);
        self.addSubview(label);
        return label;
    }()
}
