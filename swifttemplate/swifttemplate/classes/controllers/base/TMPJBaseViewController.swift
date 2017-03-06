//
//  TMPJBaseViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJBaseViewController: UIViewController {
    fileprivate var overlyView:ETTapView?
    init()
    {
        super.init(nibName: nil, bundle: nil);
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate lazy var waitingActivity:UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray);
        activity.center = CGPoint(x:self.view.width/2,y:self.view.height/2);
        return activity;
    }()
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.setLeftReturnIcon();
    }
    func leftItemAction(_ sender:AnyObject?)
    {
       let _ = self.navigationController?.popViewController(animated: true);
    }
    func rightItemAction(_ sender:AnyObject?){
        
    }
    final func setLeftReturnIcon(){
        let image = UIImage(named: "common_icon_back") ?? UIImage.arrow(with: .left)
        let item = ETNavigationBarItem.init(image: image, selectedImage: nil, action: #selector(TMPJBaseViewController.leftItemAction(_:)));
        self.setLeftBarItems([item,ETNavigationBarItem(fixed: 10)]);
    }
    final func setRightImageName(_ imageName:String)
    {
        let image = UIImage(named:imageName);
        let item = ETNavigationBarItem.init(image:image!, selectedImage: nil, action: #selector(TMPJBaseViewController.rightItemAction(_:)));
        self.setRightBarItems([item,ETNavigationBarItem(fixed: 10)]);
    }
    final func setLeftImageName(_ imageName:String)
    {
        let image = UIImage(named:imageName);
        let item = ETNavigationBarItem.init(image:image!, selectedImage: nil, action: #selector(TMPJBaseViewController.leftItemAction(_:)));
        self.setLeftBarItems([item,ETNavigationBarItem(fixed: 10)]);
    }
    final func setRightBarTitle(_ title:String,titleColor:UIColor? = nil,titleFont:UIFont? = nil,offsetFromRight:CGFloat = -10.0)
    {
        let item = ETNavigationBarItem(title: title, action: #selector(TMPJBaseViewController.rightItemAction(_:)));
        item.titleFont = titleFont;
        item.titleColor = titleColor;
        self.setRightBarItems([item,ETNavigationBarItem(fixed:offsetFromRight)]);
    }
    final func setLeftBarTitle(_ title:String,titleColor:UIColor? = nil,titleFont:UIFont? = nil,offsetFromLeft:CGFloat = -10)
    {
        let item = ETNavigationBarItem.init(title: title, action: #selector(TMPJBaseViewController.leftItemAction(_:)));
        item.titleFont = titleFont;
        item.titleColor = titleColor;
        self.setRightBarItems([item,ETNavigationBarItem(fixed: offsetFromLeft)]);
    }
    final func showWaitingActivity(){
        if (self.waitingActivity.superview == nil)
        {
            self.view.addSubview(self.waitingActivity);
            self.waitingActivity.startAnimating();
        }
    }
    
    final func hideWaiting()
    {
        
        self.waitingActivity.stopAnimating();
        self.waitingActivity.removeFromSuperview();
    }
    
    final func showAlertMessage(_ message:String,clickedAction:((UIView)->Void)?)
    {
        self.showAlertMessage(message, inRect: self.view.bounds, clickedAction: clickedAction)
    }
    final func showAlertMessage(_ message:String,inRect:CGRect,clickedAction:((UIView)->Void)?)
    {
        if message.lengthOfBytes(using: String.Encoding.utf8)>0
        {
            self.removeAlert();
            let overlay = ETTapView(frame: inRect);
            overlay.backgroundColor=UIColor.white;
            let label = UILabel(frame: CGRect(x:10,y: inRect.size.height/2-25,width: inRect.size.width-20,height: 50));
            label.font = UIFont.systemFont(ofSize: 16);
            label.textAlignment = .center;
            label.numberOfLines = 2;
            label.textColor = ETColorFromRGB(0x677386);
            label.text = message;
            overlay.addSubview(label);
            if let action = clickedAction
            {
                overlay.tapAction=action;
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
    func dismissKeyboard()
    {
        self.view.endEditing(true);
    }
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
            return UIStatusBarStyle.lightContent;
    }
}
