//
//  TMPJNavigationController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import UIKit

class TMPJNavigationController: UINavigationController {

    override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController;
    }
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController;
    }

}
