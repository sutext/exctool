//
//  TMPJTextView.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey

class TMPJTextView: AMTextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    convenience init(){
        self.init(frame: .zero, textContainer: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}

class TMPJTextLabel:UITextView{
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .size13
        self.textColor = UIColor(0x333333)
        self.isEditable = false
        self.isScrollEnabled = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isUserInteractionEnabled = false
        self.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.theme]
    }
    convenience init(){
        self.init(frame: .zero, textContainer: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    func setup(attrText:NSMutableAttributedString){
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        attrText.addAttributes([.paragraphStyle:style,
                                .font:self.font!,
                                .foregroundColor:self.textColor!],
                               range: NSMakeRange(0, attrText.length))
        self.attributedText = attrText
    }
}
