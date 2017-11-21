//
//  TMPJCollectionViewCell.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setupUI();
    }
    lazy var imageView:TMPJImageView = {
        var image = TMPJImageView();
        image.clipsToBounds = true;
        self.contentView.addSubview(image);
        return image;
    }()
    lazy var textLabel:TMPJLabel = {
        var label = TMPJLabel();
        label.font = .size14
        label.textColor = .mainText
        self.contentView.addSubview(label);
        return label;
    }()
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc dynamic func setupUI(){
        
    }
}
