//
//  TMPLLabel.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import Airmey

class TMPJLabel: AMLabel {
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    init() {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func defaultShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
    }
}
extension TMPJLabel{
    func setup(exp:Int64,total:Int64){
        let string = "\(exp)/\(total)"
        let attrString = NSMutableAttributedString(string: string)
        attrString.setAttributes([.foregroundColor : UIColor.theme], range: NSMakeRange(0, Int(exp.description.length)))
        self.attributedText = attrString
    }
}

