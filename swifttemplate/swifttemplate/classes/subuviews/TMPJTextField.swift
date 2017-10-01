//
//  TMPJTextField.swift
//  swifttemplate
//
//  Created by supertext on 2017/5/20.
//  Copyright © 2017年 icegent. All rights reserved.
//

import EasyTools

class TMPJTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
class TMPJRegistTextField : UITextField{
    var textLabel:TMPJLabel?
    var sended : Bool = false
    {
        didSet {
            if self.sended
            {
                self.textLabel?.isUserInteractionEnabled = false;
                var count = 60;
                func refsres()
                {
                    if !self.sended {return}
                    self.textLabel?.text = "已发送(\(count))";
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                        count -= 1;
                        if (count > 0)
                        {
                            refsres();
                        }
                        else
                        {
                            self.sended = false;
                            
                        }
                        
                    })
                }
                refsres();
            }
            else
            {
                self.textLabel?.isUserInteractionEnabled = true;
                self.textLabel?.text = "获取验证码";
            }
        }
    }
    convenience init (sendAction: ((ETTapLabel) -> Void)? = nil)
    {
        self.init();
        self.keyboardType = .numberPad
        self.rightViewMode = .always;
        let label = TMPJLabel();
        label.text = "获取验证码";
        label.textColor = kTMPJThemeColor;
        label.font = UIFont.systemFont(ofSize: ETScaledFloat(12));
        label.textAlignment = .center;
        label.setTextInsets(UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5));
        label.layer.borderColor = kTMPJThemeColor.cgColor;
        label.layer.borderWidth = 1;
        label.clipsToBounds = true;
        label.sizeToFit();
        label.layer.cornerRadius = label.height/2;
        label.tapAction = sendAction;
        self.rightView = label;
        self.textLabel = label;
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds);
        rect.origin.x = 20;
        if (self.rightView != nil)
        {
            rect.size.width = self.width - self.rightView!.width-40;
        }
        return rect;
    }
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds);
        if (self.rightView != nil)
        {
            return CGRect.zero;
        }
        else
        {
            rect.origin.x = self.width - 40;
        }
        return rect;
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds);
        rect.origin.x = 20;
        if (self.rightView != nil)
        {
            rect.size.width = self.width - self.rightView!.width-40;
        }
        return rect;
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds);
        if (self.rightView != nil)
        {
            rect.origin.x = self.width - self.rightView!.width-12;
            rect.size.width = self.rightView!.width;
        }
        return rect;
    }
}
