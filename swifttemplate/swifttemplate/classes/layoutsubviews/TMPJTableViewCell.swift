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
    var value:String?
    var icon:String?
    var target:UIViewController.Type?
    var isEnabled:Bool
    fileprivate var swich:UISwitch?
    private var switchAction:((_ sender:TMPJCellModel,_ swi:UISwitch)->Void)?
    init (title:String?=nil,value:String? = nil,icon:String? = nil,target:TMPJBaseViewController.Type? = nil,isEnabled:Bool = false)
    {
        self.title = title
        self.value = value
        self.icon = icon
        self.target = target
        self.isEnabled = isEnabled
    }
    func usingSwitch(_ inival:Bool? = nil , action:((_ sender:TMPJCellModel,_ swi:UISwitch)->Void)? = nil)
    {
        if let val = inival{
            self.value = val ? "1" : "0"
        }
        self.swich = UISwitch();
        self.swich?.isOn = self.value == "1"
        self.switchAction = action;
        self.swich?.addTarget(self, action: #selector(TMPJCellModel.valueChanged(_:)), for: .valueChanged);
    }
    @objc private func valueChanged(_ swi:UISwitch)
    {
        self.value = (swi.isOn ? "1" : "0")
        self.switchAction?(self,swi)
    }
}
class TMPJTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = .white;
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class TMPJCustomTableViewCell: TMPJTableViewCell {
    lazy var iconView:TMPJImageView = {
        var icon = TMPJImageView();
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true;
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
        self.separatorInset = .zero;
        self.setupUI()
    }
    @objc dynamic func setupUI(){
        
    }
}
class TMPJValuedTableViewCell: TMPJTableViewCell {
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
        
        if let swi = model.swich
        {
            swi.isOn = (model.value == "1")
            self.accessoryView = swi
            self.detailTextLabel?.text = nil
        }else{
            self.accessoryView = nil
            self.detailTextLabel?.text = model.value
        }
        
        if let image = model.icon
        {
            self.imageView?.image = UIImage(named:image);
        }else
        {
            self.imageView?.image = nil
        }
        
        if model.isEnabled{
            self.selectionStyle = .default
            self.accessoryType = .disclosureIndicator
        }else{
            self.selectionStyle = .none
            self.accessoryType = .none
        }
    }
}
extension TMPJValuedTableViewCell:TMPJTableViewReuseableCell{}
class TMPJTableViewHeaderCell: TMPJValuedTableViewCell {
    let markView = TMPJLayoutAssist(w: 3, h: 17)
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        self.markView.backgroundColor = .theme
        self.contentView.addSubview(self.markView)
        self.contentView.backgroundColor = .white
        self.markView.leftAnchor.equal(to: self.contentView.leftAnchor)
        self.markView.centerYAnchor.equal(to: self.contentView.centerYAnchor)
    }
}
class TMPJTableViewHeaderView: UITableViewHeaderFooterView {
    let markView = TMPJLayoutAssist(w: 3, h: 17)
    let titleLabel = TMPJLabel()
    let rightArrow = TMPJImageView(w:7,h:12)
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.markView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.rightArrow)
        self.contentView.backgroundColor = .white
        self.titleLabel.font = .size14
        self.titleLabel.textColor = .mainText
        self.markView.leftAnchor.equal(to: self.contentView.leftAnchor)
        self.titleLabel.leftAnchor.equal(to: self.markView.rightAnchor,offset:12)
        self.rightArrow.rightAnchor.equal(to: self.contentView.rightAnchor,offset:-15)
        self.markView.centerYAnchor.equal(to: self.contentView.centerYAnchor)
        self.titleLabel.centerYAnchor.equal(to: self.contentView.centerYAnchor)
        self.rightArrow.centerYAnchor.equal(to: self.contentView.centerYAnchor)
        self.markView.backgroundColor = .theme
        self.rightArrow.image = UIImage(named:"icon_right_arrow_gray")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

