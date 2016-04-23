//
//  TMPJAlertManager.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools
let kTMPJAlertManager = TMPJAlertManager();
class TMPJAlertManager {
    private let alert = ETAlertManager();
    func showError(error:NSError){
        if error.domain == ETNetworkErrorDomain
        {
            self.showAlert(message: error.userInfo[kETHeaderMeesageKey] as? String);
        }
        else
        {
            self.showAlert(message: "网络错误");
        }
    }
    func showAlert(title:String? = "提示" , message:String? = nil , cancelTitle:String? = "确定" , otherTitle:String? = nil , hiddenAction:((alert:UIAlertController,idx:Int)->Void)? = nil)
    {
        self.alert.showAlertWihtTitle(title, message: message, cancelButtonTitle: cancelTitle, otherButtonTitle: otherTitle, onHiddenAtIndex: hiddenAction);
    }
    func showWaiting(message:String,appeared:((sender:UIView)->Void)? = nil,cancel:((sender:UIView)->Void)? = nil)
    {
        self.alert.showWaitingMessage(message, appearComplete: appeared, canceled: cancel);
    }
    func showSuccess(message:String,completed:((sender:UIView)->Void)? = nil)
    {
        self.alert.showIconMessage(message, iconStyle: .OK , hideComplete: completed);
    }
    func hideWaiting(completed:((sender:UIView)->Void)? = nil)
    {
        self.alert.hideWaiting(completed);
    }

}
