//
//  TMPJTextField.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey
class TMPJTextField: UITextField {
    init() {
        super.init(frame:CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds);
        rect.origin.x = 15;
        rect.size.width = self.frame.width - 30;
        return rect;
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds);
        rect.origin.x = 15;
        rect.size.width = self.frame.width - 30;
        return rect;
    }
    
}
class TMPJLoginTextField : UITextField {
    init(){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.widthAnchor.equal(to: .screenWidth - 50)
        self.heightAnchor.equal(to: 44)
        self.keyboardType = .asciiCapable
        self.leftViewMode = .always
        self.clearButtonMode = .unlessEditing;
        self.textColor = .mainText;
        self.tintColor = .subText;
        self.font = .size14;
        let line = TMPJLayoutAssist()
        self.addSubview(line)
        line.adhere(right: 10)
        line.adhere(left: 30)
        line.adhere(bottom: 0)
        line.heightAnchor.equal(to: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds);
        rect.origin.x = 10;
        return rect;
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds);
        rect.origin.x = 40;
        rect.size.width = self.frame.width - 60;
        return rect;
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds);
        rect.origin.x = 40;
        rect.size.width = self.frame.width - 60;
        return rect;
    }
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds);
        rect.origin.x = self.frame.width - 10 - rect.size.width;
        return rect;
    }
}

class TMPJRegistTextField : TMPJLoginTextField{
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
    convenience init (sendAction: ((AMLabel) -> Void)? = nil)
    {
        self.init()
        self.keyboardType = .numberPad
        self.rightViewMode = .always
        let label = TMPJLabel();
        label.text = "获取验证码";
        label.textColor = .theme;
        label.font = .size12
        label.textAlignment = .center;
        label.textInsets = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
        label.layer.borderColor = UIColor.theme.cgColor;
        label.layer.borderWidth = 1;
        label.clipsToBounds = true;
        label.sizeToFit();
        label.layer.cornerRadius = label.frame.height/2;
        label.tapAction = sendAction
        self.rightView = label;
        self.textLabel = label;
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds);
        if (self.rightView != nil)
        {
            rect.origin.x = self.frame.width - self.rightView!.frame.width-12;
            rect.size.width = self.rightView!.frame.width;
        }
        return rect;
    }
}

