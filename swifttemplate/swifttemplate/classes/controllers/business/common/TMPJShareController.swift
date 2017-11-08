//
//  TMPJShareController.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey
import OpenPlatform

final class TMPJShareController: TMPJBaseViewController{
    private let titleLabel = TMPJLabel()
    private let cancelButton = TMPJButton.cover(title: "取消", size: CGSize(width:.screenWidth,height:40), titleColor: .mainText, titleFont: .size14, imageColor: UIColor(0xf5f5f5))
    private let scorllView  = TMPJScrollView()
    private let stackView = TMPJStackView.defualt
    private var adapter = AMPresentFrameAssistor(193)
    var dismissBlock:((Channel)->Void)?
    var channels = Channel.all
    override init() {
        super.init()
        self.transitioningDelegate = self.adapter
        self.modalPresentationStyle = .custom
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.scorllView)
        self.view.addSubview(self.cancelButton)
        self.scorllView.addSubview(self.stackView)
        self.scorllView.delaysContentTouches = false;
        for channle in self.channels
        {
            self.addButton(for: channle)
        }
        self.view.backgroundColor = .white
        self.stackView.spacing = (CGFloat.screenWidth - 240)/3
        self.titleLabel.font = .size14
        self.titleLabel.textColor = .subText
        self.titleLabel.text = "分享:"
        
        self.titleLabel.topAnchor.equal(to: self.view.topAnchor,offset:15)
        self.scorllView.topAnchor.equal(to: self.titleLabel.bottomAnchor,offset:15)
        self.scorllView.bottomAnchor.equal(to: self.cancelButton.topAnchor)
        self.cancelButton.bottomAnchor.equal(to: self.view.bottomAnchor);
        
        self.titleLabel.leftAnchor.equal(to: self.view.leftAnchor,offset:20)
        self.scorllView.leftAnchor.equal(to: self.view.leftAnchor)
        self.scorllView.rightAnchor.equal(to: self.view.rightAnchor)
        self.cancelButton.leftAnchor.equal(to: self.view.leftAnchor)
        
        self.stackView.leftAnchor.equal(to: self.scorllView.leftAnchor,offset:20)
        self.stackView.rightAnchor.equal(to: self.scorllView.rightAnchor,offset:-20)
        self.stackView.topAnchor.equal(to: self.scorllView.topAnchor)
        self.stackView.bottomAnchor.equal(to: self.scorllView.bottomAnchor);
        
        self.cancelButton.clickedAction = {[weak self] sender in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    private func addButton(for channel:Channel){
        let button = TMPJButton.bottom(imageName: channel.rawValue, title: channel.name, imageSize: CGSize(width:50,height:50))
        button.clickedAction = {[weak self] sender in
            self?.clicked(at: channel)
        }
        self.stackView.addArrangedSubview(button)
    }
    private func clicked(at channel:Channel){
        self.dismiss(animated: false) {
            self.dismissBlock?(channel)
        }
    }
    
}
extension TMPJShareController{
    enum Channel : String{
        case dynamic = "icon_share_karaok"
        case message = "icon_share_message"
        case wechat  = "icon_share_wechat"
        case moment  = "icon_share_moment"
        case weibo   = "icon_share_weibo"
        case qq      = "icon_share_qq"
        case qqzone  = "icon_share_qqzone"
        static let all:[Channel] = [.dynamic,.wechat,
                                    .moment,.weibo,.qq,.qqzone]
        var platform:OPOpenShareType?{
            switch self {
            case .qq:
                return .QQ
            case .weibo:
                return .weibo
            case .qqzone:
                return .qqZone
            case .wechat:
                return .wechat
            case .moment:
                return .moments
            default:
                return nil
            }
        }
        
    }
}
extension TMPJShareController.Channel:AMNameConvertible{
    var name: String{
        switch self {
        case .dynamic:
            return "动态"
        case .message:
            return "私信"
        case .wechat:
            return "微信"
        case .moment:
            return "朋友圈"
        case .weibo:
            return "微博"
        case .qq:
            return "QQ"
        case .qqzone:
            return "QQ空间"
        }
    }
}

