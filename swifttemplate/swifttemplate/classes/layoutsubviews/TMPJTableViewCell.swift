//
//  TMPJTableViewCell.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJCellModel {
    var title:String?
    var icon:String?
    var target:UIViewController.Type?
    var isEnabled:Bool
    fileprivate var valueView:UIView?
    var changeAction:((TMPJCellModel)->Void)?
    init (_ title:String?=nil,value:Value = .none,icon:String? = nil,target:TMPJBaseViewController.Type? = nil,isEnabled:Bool = false)
    {
        self.title = title
        self.icon = icon
        self.target = target
        self.isEnabled = isEnabled
        self.value = value
        self.setup(value: value)
    }
    init (_ title:String?=nil,text:AMTextConvertible?,icon:String? = nil,target:TMPJBaseViewController.Type? = nil,isEnabled:Bool = false)
    {
        self.title = title
        self.icon = icon
        self.target = target
        self.isEnabled = isEnabled
        self.value = .text(text)
        self.setup(value: self.value)
    }
    var value:Value{
        didSet{
            self.setup(value: value)
        }
    }
    var ison:Bool{
        get{
            if case .switch(let bool) = self.value{
                return bool
            }
            return false
        }
        set{
            self.value = .switch(newValue)
        }
    }
    var isLoading:Bool{
        get{
            if case .loading(let bool) = self.value{
                return bool
            }
            return false
        }
        set{
            self.value = .loading(newValue)
        }
    }
    var text:String?{
        get{
            if case .text(let val) = self.value{
                return val?.text
            }
            return nil
        }
        set{
            self.value = .text(newValue)
        }
    }
    var badge:Int{
        get{
            if case .badge(let int) = self.value{
                return int
            }
            return 0
        }
        set{
            self.value = .badge(newValue)
        }
    }
    enum Value {
        case none
        case text(AMTextConvertible?)
        case badge(Int)
        case loading(Bool)
        case `switch`(Bool)
    }
}

extension TMPJCellModel{
    private func setup(value:Value){
        switch value {
        case .none:
            self.valueView = nil
            return
        case .loading(let isLoading):
            guard let view = self.valueView else{
                self.setupLoading(isLoading)
                return
            }
            switch view {
            case let activity as UIActivityIndicatorView:
                if isLoading{
                    activity.startAnimating()
                }else{
                    activity.stopAnimating()
                }
            default:
                self.setupLoading(isLoading)
            }
        case .switch(let ison):
            guard let view = self.valueView else{
                self.setupSwitch(ison: ison)
                return
            }
            switch view{
            case let sw as UISwitch:
                sw.isOn = ison
            default:
                self.setupSwitch(ison: ison)
                break
            }
            
        case .badge(let badge):
            guard let view = self.valueView else{
                self.setupBadge(badge: badge)
                return
            }
            switch view{
            case let label as AMBadgeLabel:
                label.badge = badge
            default:
                self.setupBadge(badge: badge)
                break
            }
        case .text(let text):
            guard let view = self.valueView else{
                self.setupLabel(text:text?.text)
                return
            }
            switch view{
            case let label as TMPJLabel:
                label.text = text?.text
            default:
                self.setupLabel(text: text?.text)
                break
            }
            view.sizeToFit()
        }
    }
    @objc private func valueChanged(_ sender:UISwitch)
    {
        self.value = .switch(sender.isOn)
        self.changeAction?(self)
    }
    private func setupSwitch(ison:Bool){
        let sw = UISwitch()
        sw.isOn = ison
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(TMPJCellModel.valueChanged(_:)), for: .valueChanged);
        self.valueView = sw
    }
    private func setupLabel(text:String?){
        let label = TMPJLabel()
        label.font = .size14
        label.textColor = .subText
        label.text = text
        self.valueView = label
    }
    private func setupBadge(badge:Int){
        let label = AMBadgeLabel(badge: badge,color:.theme)
        self.valueView = label
    }
    private func setupLoading(_ isLoading:Bool){
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        if isLoading {
            view.startAnimating()
        }
        self.valueView = view
    }
}
extension TMPJCellModel.Value:ExpressibleByStringLiteral{
    init(stringLiteral value: String) {
        self = .text(value)
    }
}
class TMPJTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = .white
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class TMPJCustomTableViewCell: TMPJTableViewCell {
    lazy var iconView:TMPJImageView = {
        var icon = TMPJImageView();
        self.contentView.addSubview(icon);
        return icon;
    }()
    lazy var titleLabel:TMPJLabel = {
        let label = TMPJLabel()
        label.textColor = .mainText
        label.font = .size14
        self.contentView.addSubview(label)
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none
        self.separatorInset = .zero
        self.setupUI()
    }
    @objc dynamic func setupUI(){
        
    }
}
class TMPJValuedTableViewCell: TMPJTableViewCell {
    var valueView:UIView?{
        didSet{
            guard let newone = valueView else {
                if oldValue?.superview == self.contentView{
                    oldValue?.removeFromSuperview()
                }
                return
            }
            guard newone != oldValue else {
                return
            }
            if oldValue?.superview == self.contentView{
                oldValue?.removeFromSuperview()
            }
            self.contentView.addSubview(newone)
            newone.align(centerY: nil)
            var right:CGFloat? = nil
            if case .none = self.accessoryType {
                right = 15
            }
            newone.adhere(right: right)
            if let label = self.textLabel {
                newone.leftAnchor.greater(than: label.rightAnchor,offset: 40)
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier);
        self.textLabel?.font = .size14
        self.detailTextLabel?.font = .size14
    }
    func setup(model:TMPJCellModel)
    {
        if let title = model.title{
            self.textLabel?.text = title
        }else{
            self.textLabel?.text = nil
        }
        
        if model.isEnabled{
            self.selectionStyle = .default
            self.accessoryType = .disclosureIndicator
        }else{
            self.selectionStyle = .none
            self.accessoryType = .none
        }
        
        if let image = model.icon
        {
            self.imageView?.image = UIImage(named:image);
        }else
        {
            self.imageView?.image = nil
        }
        self.valueView = model.valueView
    }
}

