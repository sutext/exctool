//
//  TMPJShareController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey
import OpenPlatform

final class TMPJShareController: UIViewController{
    private let effectView = AMEffectView()
    private let titleLabel = TMPJLabel()
    private let cancelBar = TMPJCancelBar()
    private let scorllView  = TMPJScrollView()
    private let stackView = TMPJStackView.defualt
    private var adapter = AMPresentFrameAssistor(153 + .tabbarHeight)
    var dismissBlock:((Channel)->Void)?
    var channels = Channel.all
    init() {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self.adapter
        self.modalPresentationStyle = .custom
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.effectView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.scorllView)
        self.view.addSubview(self.cancelBar)
        self.scorllView.addSubview(self.stackView)
        self.scorllView.delaysContentTouches = false
        for channle in self.channels
        {
            self.addButton(for: channle)
        }
        self.stackView.spacing = (CGFloat.screenWidth - 240)/3
        self.titleLabel.font = .size14
        self.titleLabel.textColor = .subText
        self.titleLabel.text = "分享:"
        
        self.effectView.adhere(insets: nil)
        self.titleLabel.adhere(top: 15)
        self.scorllView.adhere(top: 45)
        self.scorllView.bottomAnchor.equal(to: self.cancelBar.topAnchor)
        self.titleLabel.adhere(left: 20)
        self.scorllView.adhere(left: nil)
        self.scorllView.adhere(right: nil)
        self.stackView.adhere(insets: (0,20,0,20))
        
        self.cancelBar.control.addTarget(self, action: #selector(TMPJShareController.cancelAction), for: .touchUpInside)
    }
    @objc private func cancelAction(){
        self.dismiss(animated: true, completion: nil)
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

