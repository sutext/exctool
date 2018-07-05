//
//  TMPJCollectionView.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//


import Airmey

class TMPJCollectionView: AMCollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsHorizontalScrollIndicator=false
        self.alwaysBounceVertical = true
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
