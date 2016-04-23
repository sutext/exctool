//
//  TMPJRefreshControl.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools
class TMPJRefreshControl :UIView,ETRefreshProtocol {
    
    var enabled: Bool
    {
        @objc(isEnabled) get {
            return false;
        }
        set(enable)
        {
        
        }
    }
    required init() {
        super.init(frame: CGRect());
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func isRefreshing() -> Bool
    {
        return false;
    }
    func beginRefreshing()
    {
        
    }
    func endRefreshing()
    {
        
    }
    func addTarget(target: AnyObject?, action: Selector, forControlEvents controlEvents: UIControlEvents)
    {
    
    }
    func removeTarget(target: AnyObject?, action: Selector, forControlEvents controlEvents: UIControlEvents)
    {
    
    }
    override func willMoveToSuperview(newSuperview: UIView?)
    {
    
    }
}
