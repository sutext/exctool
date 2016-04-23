//
//  TMPJCollectionViewCell.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJCollectionViewCell: UICollectionViewCell {
    lazy var imageView:TMPJImageView = {
        var image = TMPJImageView(frame:self.bounds);
        self.contentView.addSubview(image);
        return image;
    }()
    lazy var textLabel:TMPJLabel = {
        var label = TMPJLabel(frame:self.bounds);
        self.contentView.addSubview(label);
        return label;
    }()
}
