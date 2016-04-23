//
//  TMPJLayoutViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

final class TMPJLayoutViewController: ETLayoutViewController {
    
    static let sharedController = TMPJLayoutViewController();
    
    private convenience init()
    {
        self.init(rootViewController:TMPJNavigationController(rootViewController: TMPJMainViewController()));
        self.modalTransitionStyle = .FlipHorizontal;
        self.leftViewController = TMPJLeftSideController();
        self.leftDisplayVector = CGVector(dx: ETScaledFloat(245), dy: 64);
    }
    
    override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.rootViewController;
    }
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.rootViewController;
    }
}
