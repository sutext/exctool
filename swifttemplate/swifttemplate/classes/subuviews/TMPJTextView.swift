//
//  TMPJTextView.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey

class TMPJTextView: UITextView {
    @objc dynamic var placeholder:String?{
        get{
            return self.holderLabel.text
        }
        set{
            self.holderLabel.text = newValue
        }
    }
    private var holderLabel:UILabel{
        if let label = self.value(forKey: "_placeholderLabel") as? UILabel{
            return label
        }
        let label = UILabel()
        label.font = .size14
        label.backgroundColor = .clear
        label.textColor = UIColor(0xaaaaaa)
        self.setValue(label, forKey: "_placeholderLabel")
        self.addSubview(label)
        return label
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .size14
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
