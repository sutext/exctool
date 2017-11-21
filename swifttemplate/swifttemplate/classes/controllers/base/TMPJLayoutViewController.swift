//
//  TMPJLayoutViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

final class TMPJLayoutViewController: AMSideViewContrller {
    
    static let shared = TMPJLayoutViewController();
    
    private convenience init()
    {
        self.init(rootViewController: TMPJMainViewController())
        self.modalTransitionStyle = .flipHorizontal;
    }
    override var childViewControllerForStatusBarStyle: UIViewController?
    {
        return self.rootViewController;
    }
    override var childViewControllerForStatusBarHidden: UIViewController?
    {
        return self.rootViewController;
    }
    func pushViewController(controller:UIViewController,animated:Bool)
    {
        self.dismissCurrentController(animated: true)
        (self.rootViewController as! UINavigationController).pushViewController(controller, animated: animated);
    }
}
