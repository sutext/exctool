//
//  TMPJPopupService.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

let pop = TMPJPopupService()

final class TMPJPopupService {
    
    
    fileprivate init(){}
    private weak var wating:(UIViewController & AMControllerWaitable)?
    private weak var current:UIViewController?
    func alert(error:Error){
        switch error {
        case let err as TMPJAlertable:
            self.alert(title:err.title,message: err.message)
        default:
            self.alert(message: "网络连接失败")
        }
    }
    func alert(title:String?="提示",message:String?,ensure:String = "确定",cancel:String?=nil,dismissIndex:((Int)->Void)?=nil){
        guard self.current == nil else {
            return
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.current = alert
        alert.addAction(UIAlertAction(title: ensure, style: .default, handler: { (action) in
            dismissIndex?(0)
        }))
        if let cancel = cancel{
            alert.addAction(UIAlertAction(title: cancel, style: .default, handler: { (action) in
                dismissIndex?(1)
            }))
        }
        
        UIApplication.shared.lastPresentedController?.present(alert, animated: true, completion: nil)
    }
    func waiting(message:String,appeared:(()->Void)?=nil,canceled:(()->Void)? = nil) {
        self.waiting(AMWaitingController(message), appeared: appeared, canceled: canceled)
    }
    func waiting<Controller:AMControllerWaitable>(_ controller:Controller,appeared:(()->Void)?=nil,canceled:(()->Void)? = nil){
        guard self.current == nil else {
            return
        }
        controller.transitioningDelegate = controller.assistor
        controller.modalPresentationStyle = .custom
        controller.assistor.appearedBlock = appeared
        self.wating = controller
        self.current = controller
        UIApplication.shared.lastPresentedController?.present(controller, animated: true, completion: nil)
    }
    func dismiss(finished:(()->Void)?=nil) {
        guard let waiting = self.wating else {
            return
        }
        waiting.dismiss(animated: true, completion: {
            finished?()
        })
    }
    func remind(_ type:RemindType,dismissed:(()->Void)?=nil) {
        guard self.current == nil else {
            return
        }
        var message:String?
        switch type {
        case .succeed(let info):
            message = info
        case .failure(let info):
            message = info
        case .error(let err as TMPJAlertable):
            message = err.message
        default:
            message = "网络连接失败"
        }
        let remind = AMRemindController(message)
        self.current = remind
        remind.assistor.dismissBlock = dismissed
        UIApplication.shared.lastPresentedController?.present(remind, animated: true, completion: nil)
    }
    func action<ActionItem:AMTextConvertible>(_ items:[ActionItem],style:ActionStyle = .plain,dismissIndex:((ActionItem,Int)->Void)?){
        guard self.current == nil else {
            return
        }
        guard items.count > 0 else {
            return
        }
        var vc:UIViewController?
        switch style {
        case .system:
            let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            for item in items.enumerated() {
                action.addAction(UIAlertAction(title: item.element.text, style: .default, handler: { (action) in
                    dismissIndex?(item.element,item.offset)
                }))
            }
            action.addAction(UIAlertAction(title: "取消", style: .cancel))
            vc = action
        case .plain:
            let plain = TMPJActionController(items)
            plain.finishBlock = {sender,item,index in
                dismissIndex?(item,index)
            }
            vc = plain
        }
        UIApplication.shared.lastPresentedController?.present(vc!, animated: true, completion: nil)
    }

}
extension TMPJPopupService{
    enum RemindType {
        case succeed(String)
        case failure(String)
        case error(Error)
    }
    enum ActionStyle {
        case system
        case plain
    }
}
