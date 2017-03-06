//
//  TMPJRefreshControl.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools
class TMPJRefreshControl :UIView,ETRefreshProtocol {
    var isEnabled: Bool
    {
        get {
            return false;
        }
        @objc(setEnabled:) set(enable)
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
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        
    }
    func removeTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        
    }
    override func willMove(toSuperview newSuperview: UIView?)
    {
    
    }
}
