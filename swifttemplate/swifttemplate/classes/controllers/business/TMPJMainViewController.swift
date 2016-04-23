//
//  TMPJMainViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJMainViewController: TMPJTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor=UIColor.whiteColor()
    }
    override func leftItemAction(sender: AnyObject!) {
        TMPJLayoutViewController.sharedController.showLeftViewController(true);
    }
}
