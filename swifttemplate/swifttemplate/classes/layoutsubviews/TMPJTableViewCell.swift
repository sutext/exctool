//
//  TMPJTableViewCell.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools
class TMPJCellModle : NSObject{
    var title:String;
    var value:String;
    var icon:String?;
    var target:UIViewController.Type?;
    fileprivate var swich:UISwitch?
    private var switchAction:((_ sender:TMPJCellModle,_ value:String)->Void)?
    init (title:String,value:String = "",icon:String? = nil,target:TMPJBaseViewController.Type? = nil)
    {
        self.title = title;
        self.value = value;
        self.icon = icon;
        self.target = target;
    }
    func usingSwitch()
    {
        self.usingSwitch(nil);
    }
    func usingSwitch(_ action:((_ sender:TMPJCellModle,_ value:String)->Void)?)
    {
        self.swich = UISwitch();
        self.switchAction = action;
        self.swich?.addTarget(self, action: #selector(TMPJCellModle.valueChanged(_:)), for: .valueChanged);
    }
    func valueChanged(_ swi:UISwitch)
    {
        self.value = (swi.isOn ? "1" : "0")
        if let block = self.switchAction
        {
            block(self, self.value)
        }
    }
}

class TMPJTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = UIColor.clear;
        self.separatorInset = UIEdgeInsets.zero;
        self.layoutMargins = UIEdgeInsets.zero;
        self.preservesSuperviewLayoutMargins = false;
    }
    func setupModle(modle:TMPJCellModle)
    {
        self.textLabel?.text = modle.title;
        
        if let swi = modle.swich
        {
            swi.isOn = (modle.value == "1")
            self.accessoryView = swi;
        }
        else
        {
            self.detailTextLabel?.text = modle.value;
        }
        
        if let image = modle.icon
        {
            self.imageView?.image = UIImage(named:image);
        }
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
