//
//  TMPJNavigationController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJNavigationController: AMNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icon_return_white")
        self.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "icon_return_white")
    }
}
