//
//  TMPJAvatarView.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJAvatarView: UIView {
    private let button = TMPJButton(.cover)
    var clickedAction:((TMPJButton,TMPJUserObject?)->Void)?
    var user:TMPJUserObject?{
        didSet{
            guard user != oldValue else {
                return
            }
            if let oldone = oldValue{
                oldone.removeObserver(self, forKeyPath: "avatar")
            }
            guard let newone = user else{
                return
            }
            newone.addObserver(self, forKeyPath: "avatar", options: .new, context: nil)
            self.button.setImage(url: newone.avatar)
            guard let account = newone.account else {
                return
            }
            self.button.clickedAction = {[weak self]sender in
                guard let wself = self else{
                    return
                }
                if let block = wself.clickedAction{
                    block(wself.button,wself.user)
                    return
                }
                let info = TMPJUserInfoController(account)
                layout?.pushViewController(info, animated: true)
            }
        }
    }
    deinit {
        self.user?.removeObserver(self, forKeyPath: "avatar")
    }
    init(size:CGFloat,border:CGFloat = 0){
        super.init(frame:.zero)
        self.addSubview(self.button)
        self.clipsToBounds = true
        self.layer.cornerRadius = size/2
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clamp(width: size, height: size)
        
        let imageRadius = size/2 - border
        let item = AMButtonItem()
        item.imageSize = CGSize(width:2*imageRadius,height:imageRadius*2)
        item.cornerRadius = imageRadius
        item.image = #imageLiteral(resourceName: "default_avatar")
        self.button.apply(item: item, for: .normal)
        self.button.align(centerX: nil)
        self.button.align(centerY: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "avatar"{
            DispatchQueue.main.async {
                self.button.setImage(url: self.user?.avatar)
            }
        }
    }
}
