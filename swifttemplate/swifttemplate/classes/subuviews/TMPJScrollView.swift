//
//  TMPJScrollView.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit
class TMPJScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delaysContentTouches = false
    }
    convenience init() {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
}
