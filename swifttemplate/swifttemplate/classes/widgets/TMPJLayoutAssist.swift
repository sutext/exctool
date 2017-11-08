//
//  TMPJLayoutAssist.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
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
        self.constraint(width: w, height: h)
    }
    func constraint(width:CGFloat,height:CGFloat){
        if let wc = self.wconst {
            wc.constant = width;
        }
        else
        {
            self.wconst = self.widthAnchor.equal(to: width)
        }
        if let hc = self.hconst {
            hc.constant = height;
        }
        else
        {
            self.hconst = self.heightAnchor.equal(to: height)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
