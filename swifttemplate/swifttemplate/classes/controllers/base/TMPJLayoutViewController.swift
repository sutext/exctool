//
//  TMPJLayoutViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

weak fileprivate(set) var layout:TMPJLayoutViewController?

extension UIApplication{
    func jumptoMain()  {
        self.keyWindow?.rootViewController = TMPJLayoutViewController()
    }
}
final class TMPJLayoutViewController: AMLayoutViewContrller {
    private let main:TMPJMainViewController
    private let navigation:TMPJNavigationController
    fileprivate init()
    {
        let main = TMPJMainViewController()
        let navigation = TMPJNavigationController(rootViewController:main )
        self.navigation = navigation
        self.main = main
        super.init(rootViewController: navigation)
        self.dimming = 0.3
        self.leftViewController = TMPJLeftSideController()
        self.leftDisplayVector = CGVector(dx: TMPJLeftSideController.width, dy: 0)
        self.leftDisplayMode = .cover
        layout = self
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    override var childViewControllerForStatusBarStyle: UIViewController?
    {
        return self.rootViewController;
    }
    override var childViewControllerForStatusBarHidden: UIViewController?
    {
        return self.rootViewController;
    }
    func pushViewController(_ controller:UIViewController,animated:Bool)
    {
        self.dismissCurrentController(animated: true)
        self.navigation.pushViewController(controller, animated: animated)
    }
    func popViewController(animated:Bool){
        self.navigation.popViewController(animated: animated)
    }
    func popToRootViewController(animated:Bool){
        self.navigation.popToRootViewController(animated: animated)
    }
}
