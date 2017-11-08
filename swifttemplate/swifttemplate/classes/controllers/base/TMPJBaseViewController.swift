//
//  TMPJBaseViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import Airmey
class TMPJBaseViewController: UIViewController {
    fileprivate var overlyView:TMPJView?
    fileprivate var waitingActivity:UIActivityIndicatorView?
    init()
    {
        super.init(nibName: nil, bundle: nil);
        self.hidesBottomBarWhenPushed = true
        self.automaticallyAdjustsScrollViewInsets = false
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
        self.setLeftButtons()
    }
    func reloadData() {
        
    }
    @objc func leftItemAction(_ sender:AnyObject?)
    {
        _ = self.navigationController?.popViewController(animated: true);
    }
    @objc func rightItemAction(_ sender:AnyObject?){
        
    }
    @objc func rightSecendAction(_ sender:AnyObject?){
        
    }
    func setLeftButtons()  {
        self.setWhiteReturn()
    }
    func setupBarStyle(){
        self.setNavbar(style: .default)
    }
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
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent;
    }
}
extension TMPJBaseViewController{
    typealias ImageName = (normal:String,press:String?)
    final func setBlackReturn()  {
        self.setLeftBar(name:("icon_return_black",nil))
    }
    final func setWhiteReturn()  {
        self.setLeftBar(name:("icon_return_white",nil))
    }
    final func setLeftBar(name:ImageName) {
        let item  = AMButtonItem()
        item.image = UIImage(named: name.normal)
        let button = TMPJButton(.cover)
        button.apply(item: item, for: .normal)
        if let press = name.press{
            button.setImage(UIImage(named: press), for: .highlighted)
        }
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 15)
        button.sizeToFit()
        button.addTarget(self, action: #selector(TMPJBaseViewController.leftItemAction(_:)), for: .touchUpInside)
        self.setLeftbar(item: button, fixed: 0);
    }
    final func setRightbar(_ first:ImageName,secend:ImageName? = nil) {
        let item  = AMButtonItem()
        item.image = UIImage(named: first.normal)
        item.imageSize = CGSize(width:20,height:20)
        let button = TMPJButton(.cover)
        button.apply(item: item, for: .normal)
        if let press = first.press {
            button.setImage(UIImage(named: press), for: .highlighted)
        }
        button.sizeToFit()
        button.addTarget(self, action: #selector(TMPJBaseViewController.rightItemAction(_:)), for: .touchUpInside)
        
        var items:[UIBarButtonItemConvertibal] = [button]
        if let secend = secend {
            let item  = AMButtonItem()
            item.image = UIImage(named: secend.normal)
            item.imageSize = CGSize(width:20,height:20)
            let button = TMPJButton(.cover)
            button.apply(item: item, for: .normal)
            if let press = first.press {
                button.setImage(UIImage(named: press), for: .highlighted)
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
    final func showAlertMessage(_ message:String,clickedAction:((UIView)->Void)?)
    {
        self.showAlertMessage(message, inRect: self.view.bounds, clickedAction: clickedAction)
    }
    final func showAlertMessage(_ message:String,inRect:CGRect,clickedAction:((UIView)->Void)?)
    {
        if message.lengthOfBytes(using: String.Encoding.utf8)>0
        {
            self.removeAlert();
            let overlay = TMPJView(frame: inRect);
            overlay.backgroundColor=UIColor.white;
            let label = UILabel(frame: CGRect(x:10,y: inRect.size.height/2-25,width: inRect.size.width-20,height: 50));
            label.font = .size16;
            label.textAlignment = .center;
            label.numberOfLines = 2;
            label.textColor = UIColor(0x677386);
            label.text = message;
            overlay.addSubview(label);
            if let action = clickedAction
            {
                overlay.singleAction=action;
            }
            self.overlyView = overlay;
            self.view.addSubview(overlay);
        }
    }
    final func removeAlert()
    {
        if (self.overlyView != nil)
        {
            self.overlyView?.removeFromSuperview();
            self.overlyView=nil;
        }
    }
    final func showWaitingActivity(){
        guard self.waitingActivity == nil else {
            return
        }
        self.waitingActivity = self.createActivity()
        self.view.addSubview(self.waitingActivity!)
        self.waitingActivity?.startAnimating()
    }
    final func hideWaiting()
    {
        guard let activity = self.waitingActivity else {
            return
        }
        activity.stopAnimating()
        activity.removeFromSuperview()
        self.waitingActivity = nil
    }
    private func createActivity()->UIActivityIndicatorView{
        let activity = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray);
        activity.center = CGPoint(x:self.view.width/2,y:self.view.height/2);
        return activity;
    }
}

