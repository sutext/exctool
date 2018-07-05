//
//  TMPJStackView.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit

class TMPJStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    static var `defualt`:TMPJStackView {
        get{
            let stack = TMPJStackView()
            stack.axis = .horizontal
            stack.alignment = .center
            stack.distribution = .equalSpacing
            stack.spacing = 8
            return stack
        }
    }
}
