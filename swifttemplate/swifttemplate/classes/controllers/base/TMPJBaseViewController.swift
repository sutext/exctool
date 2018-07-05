//
//  TMPJBaseViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey
class TMPJBaseViewController: UIViewController {
    private weak var remindLabel:TMPJImageLabel?
    private weak var activity:UIActivityIndicatorView?
    init()
    {
        super.init(nibName: nil, bundle: nil);
        self.hidesBottomBarWhenPushed = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = false
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupBarStyle()
    }
    //MARK overwrite point
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.backBarButtonItem?.title = "返回"
        self.setLeftButtons()
    }
    func reloadData() {
        
    }
    @objc func leftItemAction(_ sender:AnyObject?)
    {
        self.navigationController?.popViewController(animated: true);
    }
    @objc func leftAvatarAction(_ sender:AnyObject?)
    {
        layout?.showLeftController(animated: true)
    }
    @objc func rightItemAction(_ sender:AnyObject?){
        
    }
    @objc func rightSecendAction(_ sender:AnyObject?){
        
    }
    func setLeftButtons()  {
        
    }
    func setupBarStyle(){
        self.setNavbar(style: .default)
    }
    var bottomInset:CGFloat{
        return .footerHeight
    }
    var topbarInset:CGFloat{
        return .navbarHeight
    }
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent;
    }
}
///utils
extension TMPJBaseViewController{
    //util function
    final func setNavbar(color:UIColor)
    {
        self.navigationController?.navigationBar.setBarColor(color)
    }
    final func setNavbar(titleColor:UIColor) {
        self.navigationController?.navigationBar.setTitleColor(titleColor);
    }
    final func setNavbar(shadowColor:UIColor) {
        self.navigationController?.navigationBar.setShadowColor(shadowColor)
    }
    final func setNavbar(style:UINavigationBar.BarStyle) {
        self.navigationController?.navigationBar.setBarStyle(style)
    }
    final func setNavbar(alpha:CGFloat){
        self.setNavbar(titleColor: UIColor(0xffffff,alpha:alpha))
        self.setNavbar(color: UIColor(0xde4a42,alpha:alpha))
        self.setNavbar(shadowColor: UIColor(0xde4a42,alpha:alpha))
    }
    final func dismissKeyboard()
    {
        self.view.endEditing(true);
    }
}
extension TMPJBaseViewController{
    typealias Image = (normal:UIImage,press:UIImage?)
    final func setLeftAvatar(){
        let avatar = TMPJAvatarView(size: 38)
        avatar.user = global.user
        avatar.clickedAction = {[weak self]sender,user in
            self?.leftAvatarAction(nil)
        }
        self.setLeftbar(item: UIBarButtonItem(customView: avatar), fixed: 0)
    }
    final func setWhiteReturn()  {
        let item = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_return_white"), style: .plain, target: self, action: #selector(TMPJBaseViewController.leftItemAction(_:)))
        self.navigationItem.leftBarButtonItem = item
    }
    final func setLeftBar(_ image:Image) {
        let item  = AMButtonItem()
        item.image = image.normal
        item.imageSize = CGSize(width:40,height:40)
        let button = TMPJButton(.cover)
        let wspaceing = (40-image.normal.size.width)/2
        let hspaceing = (40-image.normal.size.height)/2
        button.imageEdgeInsets = UIEdgeInsets(top:hspaceing , left: wspaceing, bottom: hspaceing, right: wspaceing)
        button.apply(item: item, for: .normal)
        if let press = image.press{
            button.setImage(press, for: .highlighted)
        }
        button.sizeToFit()
        button.addTarget(self, action: #selector(TMPJBaseViewController.leftItemAction(_:)), for: .touchUpInside)
        self.setLeftbar(item: button, fixed: 0);
    }
    final func setRightbar(_ first:Image,secend:Image? = nil) {
        let item  = AMButtonItem()
        item.image = first.normal
        item.imageSize = CGSize(width:40,height:40)
        let button = TMPJButton(.cover)
        let wspaceing = (40-first.normal.size.width)/2
        let hspaceing = (40-first.normal.size.height)/2
        button.imageEdgeInsets = UIEdgeInsets(top:hspaceing , left: wspaceing, bottom: hspaceing, right: wspaceing)
        button.apply(item: item, for: .normal)
        if let press = first.press {
            button.setImage(press, for: .highlighted)
        }
        button.sizeToFit()
        button.addTarget(self, action: #selector(TMPJBaseViewController.rightItemAction(_:)), for: .touchUpInside)
        
        var items:[AMBarButtonItemConvertible] = [button]
        if let secend = secend {
            let item  = AMButtonItem()
            item.image = secend.normal
            item.imageSize = CGSize(width:40,height:40)
            let button = TMPJButton(.cover)
            button.apply(item: item, for: .normal)
            if let press = secend.press {
                button.setImage(press, for: .highlighted)
            }
            button.sizeToFit()
            button.addTarget(self, action: #selector(TMPJBaseViewController.rightSecendAction(_:)), for: .touchUpInside)
            
            let fixed = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixed.width = 15;
            items.append(fixed)
            items.append(button)
        }
        self.setRightBar(items: items)
    }
    final func setLeftbar(title:String,font:UIFont = .size17,titleColor:UIColor = .white) {
        let item = AMButtonItem()
        item.title = title;
        item.titleFont = font;
        item.titleColor = titleColor;
        let button = TMPJButton()
        button.apply(item: item, for: .normal)
        button.sizeToFit();
        button.addTarget(self, action: #selector(TMPJBaseViewController.leftItemAction(_:)), for: .touchUpInside)
        self.setLeftbar(item: button, fixed: 0);
    }
    final func setRightbar(title:String,font:UIFont = .size17,titleColor:UIColor = .white) {
        let item = AMButtonItem()
        item.title = title
        item.titleFont = font
        item.titleColor = titleColor
        let button = TMPJButton()
        button.apply(item: item, for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(TMPJBaseViewController.rightItemAction(_:)), for: .touchUpInside)
        self.setRightbar(item: button, fixed: 0)
    }
}

extension TMPJBaseViewController{
    final func remindOffline(_ offline:(()->Void)?){
        self.remind(#imageLiteral(resourceName: "remind_offline_gray"),text: "网络连接失败\n请确认网络连接后，点击此处重试",block:offline)
    }
    final func remind(_ image:UIImage? = nil,text:String,block:(()->Void)? = nil){
        guard self.remindLabel == nil else {
            return
        }
        let label = TMPJImageLabel(.top,image:image,text: text)
        label.font = .size16
        label.textColor = UIColor(0x666666)
        label.spaceing = 20
        label.numberOfLines = 2
        label.textAlignment = .center
        self.view.addSubview(label)
        label.align(centerY: nil)
        label.align(centerX: nil)
        label.singleAction = {sender in
            block?()
        }
        self.remindLabel = label
    }
    final func hideRemind()
    {
        guard let label = self.remindLabel else {
            return
        }
        label.removeFromSuperview()
        self.remindLabel = nil
    }
    final func showWaiting(_ style:UIActivityIndicatorViewStyle = .gray){
        guard self.activity == nil else {
            return
        }
        let activity = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.whiteLarge)
        activity.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activity)
        activity.align(centerX: nil)
        activity.align(centerY: nil)
        activity.startAnimating()
        self.activity = activity
    }
    final func hideWaiting()
    {
        guard let activity = self.activity else {
            return
        }
        activity.stopAnimating()
        activity.removeFromSuperview()
        self.activity = nil
    }
}

