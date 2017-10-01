//
//  TMPJAlertManager.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools
class TMPJAlertManager {
    static let shared = TMPJAlertManager();
    fileprivate let alert = ETAlertManager();
    func showError(_ error:NSError){
        if error.domain == ETNetworkErrorDomain
        {
            self.showAlert(message: error.userInfo[kETHeaderMeesageKey] as? String);
        }
        else
        {
            self.showAlert(message: "网络错误");
        }
    }
    func showAlert(_ title:String? = "提示" , message:String? = nil , cancelTitle:String? = "确定" , otherTitle:String? = nil , hiddenAction:((_ alert:UIAlertController,_ idx:Int)->Void)? = nil)
    {
        self.alert.showAlertWihtTitle(title, message: message, cancelButtonTitle: cancelTitle, otherButtonTitle: otherTitle, onHiddenAtIndex: hiddenAction);
    }
    func showWaiting(_ message:String,appeared:((_ sender:UIView)->Void)? = nil,cancel:((_ sender:UIView)->Void)? = nil)
    {
        self.alert.showWaitingMessage(message, appearComplete: appeared, canceled: cancel);
    }
    func showSuccess(_ message:String,completed:((_ sender:UIView)->Void)? = nil)
    {
        self.alert.showIconMessage(message, iconStyle: .OK , hideComplete: completed);
    }
    func hideWaiting(_ completed:((_ sender:UIView)->Void)? = nil)
    {
        self.alert.hideWaiting(completed);
    }

}
