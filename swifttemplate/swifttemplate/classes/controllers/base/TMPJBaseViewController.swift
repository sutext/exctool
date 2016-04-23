//
//  TMPJBaseViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJBaseViewController: UIViewController {
    private var overlyView:ETTapView?
    init()
    {
        super.init(nibName: nil, bundle: nil);
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var waitingActivity:UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray);
        activity.center = CGPointMake(self.view.width/2, self.view.height/2);
        return activity;
    }()
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.whiteColor();
        self.setLeftReturnIcon();
    }
    func leftItemAction(sender:AnyObject?)
    {
        self.navigationController?.popViewControllerAnimated(true);
    }
    func rightItemAction(sender:AnyObject?){
        
    }
    final func setLeftReturnIcon(){
        let image = UIImage(named: "common_icon_back");
        let item = ETNavigationBarItem.init(image: image!, selectedImage: nil, action: Selector("leftItemAction:"));
        self.setLeftBarItems([item,ETNavigationBarItem(fixed: 10)]);
    }
    final func setRightImageName(imageName:String)
    {
        let image = UIImage(named:imageName);
        let item = ETNavigationBarItem.init(image:image!, selectedImage: nil, action: Selector("rightItemAction:"));
        self.setRightBarItems([item,ETNavigationBarItem(fixed: 10)]);
    }
    final func setLeftImageName(imageName:String)
    {
        let image = UIImage(named:imageName);
        let item = ETNavigationBarItem.init(image:image!, selectedImage: nil, action: Selector("leftItemAction:"));
        self.setLeftBarItems([item,ETNavigationBarItem(fixed: 10)]);
    }
    final func setRightBarTitle(title:String,titleColor:UIColor? = nil,titleFont:UIFont? = nil,offsetFromRight:CGFloat = -10.0)
    {
        let item = ETNavigationBarItem(title: title, action: Selector("rightItemAction:"));
        item.titleFont = titleFont;
        item.titleColor = titleColor;
        self.setRightBarItems([item,ETNavigationBarItem(fixed:offsetFromRight)]);
    }
    final func setLeftBarTitle(title:String,titleColor:UIColor? = nil,titleFont:UIFont? = nil,offsetFromLeft:CGFloat = -10)
    {
        let item = ETNavigationBarItem.init(title: title, action: Selector("leftItemAction:"));
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
    
    final func showAlertMessage(message:String,clickedAction:((UIView)->Void)?)
    {
        self.showAlertMessage(message, inRect: self.view.bounds, clickedAction: clickedAction)
    }
    final func showAlertMessage(message:String,inRect:CGRect,clickedAction:((UIView)->Void)?)
    {
        if message.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)>0
        {
            self.removeAlert();
            let overlay = ETTapView(frame: inRect);
            overlay.backgroundColor=UIColor.whiteColor();
            let label = UILabel(frame: CGRectMake(10, inRect.size.height/2-25, inRect.size.width-20, 50));
            label.font = UIFont.systemFontOfSize(16);
            label.textAlignment = .Center;
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
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}
