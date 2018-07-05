//
//  TMPJValueLabel.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

final class TMPJValueLabel: TMPJView {
    enum Layout//desc the value posiation
    {
        case left
        case right
        case top
        case bottom
    }
    private(set) var layout:Layout
    private(set) var insets:AMConstraintInsets!
    private let stackView = TMPJStackView()
    private let valueLabel = TMPJLabel()
    private let titleLabel = TMPJLabel()
    init(_ layout:Layout = .left,title:String? = nil , value:String? = nil) {
        self.layout = layout
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        
        self.titleLabel.text = title
        self.valueLabel.text = value
        
        self.titleLabel.font = .size14
        self.titleLabel.textColor = .mainText
        self.valueLabel.font = .size14
        self.valueLabel.textColor = .theme
        
        self.stackView.spacing = 4.0
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .center
        
        self.insets = self.stackView.adhere(insets: nil)
        switch layout {
        case .left:
            self.stackView.axis = .horizontal
            self.stackView.addArrangedSubview(self.valueLabel)
            self.stackView.addArrangedSubview(self.titleLabel)
            
        case .right:
            self.stackView.axis = .horizontal
            self.stackView.addArrangedSubview(self.titleLabel)
            self.stackView.addArrangedSubview(self.valueLabel)
        case .top:
            self.stackView.axis = .vertical
            self.stackView.addArrangedSubview(self.valueLabel)
            self.stackView.addArrangedSubview(self.titleLabel)
        case .bottom:
            self.stackView.axis = .vertical
            self.stackView.addArrangedSubview(self.titleLabel)
            self.stackView.addArrangedSubview(self.valueLabel)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
///MARK:property accessable
extension TMPJValueLabel{
    var value:String?
    {
        get{
            return self.valueLabel.text
        }
        set {
            self.valueLabel.text = newValue
        }
    }
    var title:String?
    {
        get{
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    var valueColor:UIColor?{
        get{
            return self.valueLabel.textColor
        }
        set{
            self.valueLabel.textColor = newValue
        }
    }
    var titleColor:UIColor?{
        get{
            return self.titleLabel.textColor
        }
        set{
            self.titleLabel.textColor = newValue
        }
    }
    var valueFont:UIFont?{
        get{
            return self.valueLabel.font
        }
        set{
            self.valueLabel.font = newValue
        }
    }
    var titleFont:UIFont?{
        get{
            return self.titleLabel.font
        }
        set{
            self.titleLabel.font = newValue
        }
    }
    var spaceing:CGFloat//default 4.0
    {
        get{
            return self.stackView.spacing
        }
        set{
            self.stackView.spacing = newValue
        }
    }
    var alignment:UIStackViewAlignment{
        get{
            return self.stackView.alignment
        }
        set{
            self.stackView.alignment = newValue
        }
    }
}
