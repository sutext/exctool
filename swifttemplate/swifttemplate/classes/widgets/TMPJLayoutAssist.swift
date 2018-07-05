//
//  TMPJLayoutAssist.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit

class TMPJLayoutAssist: UIView{
    private var wconst:NSLayoutConstraint?
    private var hconst:NSLayoutConstraint?
    init ()
    {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .separator
    }
    convenience init(w:CGFloat,h:CGFloat) {
        self.init();
        self.clamp(width: w, height: h)
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
