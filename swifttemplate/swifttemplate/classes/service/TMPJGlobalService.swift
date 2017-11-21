//
//  TMPJGlobalService.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2017年 icegent. All rights reserved.
//

import UIKit
let global = TMPJGlobalService()
final class TMPJGlobalService {
    fileprivate let tokenObject = TMPJSqliteManager.shared.createToken()
    fileprivate init() {}
    let isDebug:Bool = true
    var token:String?{
        return self.tokenObject.token
    }
    lazy var asset:TMPJAssetObject = {
        return TMPJSqliteManager.shared.obtainAsset(for: self.account)
    }()
    var user :TMPJUserObject {
        guard let user = self.tokenObject.user else {
            fatalError("未登录")
        }
        return user
    }
    var account:String  {
        guard let account =  self.user.account else {
            fatalError("系统不可用")
        }
        return account
    }
    func config(){
        let navbar = UINavigationBar.appearance()
        navbar.setBarStyle(.default)
        let switchBar = UISwitch.appearance()
        switchBar.onTintColor = .theme
    }
}
extension TMPJGlobalService{
    func logout(){
        
    }
    func login(phone:String,passwd:String,completed:((Error?) -> Void)?)
    {
        TMPJNetwork.shared.datatask(TMPJAuth.Request(login: phone, passwd: passwd)) { (req, resp) in
            self.login(with: resp.value, error: resp.error, callback: completed)
        }
    }
    func login(platform:TMPJAuth.ThirdPlatform,code:String,completed:((Error?) -> Void)?)
    {
        TMPJNetwork.shared.datatask(TMPJAuth.Request(login: platform, code: code)){ (req, resp) in
            self.login(with: resp.value, error: resp.error, callback: completed)
        }
    }
    func register(phone:String,code:String,passwd:String,completed:((Error?) -> Void)?) {
        TMPJNetwork.shared.datatask(TMPJAuth.Request(register: passwd, phone: phone, code: code)){ (req, resp) in
            self.login(with: resp.value, error: resp.error, callback: completed)
        }
    }
    private func login(with object:TMPJNetworkObject?,error:Error?,callback:((Error?) -> Void)?) {
        guard let value = object else {
            callback?(error)
            return
        }
        guard let tokenstr = value.string(forKey: "token") else{
            callback?(TMPJError.analyze(info: "协议不支持"))
            return
        }
        self.tokenObject.token = tokenstr
        TMPJNetwork.shared.set(value: tokenstr, forHTTPHeaderField: "token")
//        TMPJModelService.default.user { (obj, err) in
//            if let user = obj
//            {
//                self.tokenObject.user = user
//                DispatchQueue.global().async {
//                    let group = DispatchGroup()
//                    group.enter()
//                    CKModelService.default.jury(for: user.account,update: true){ (object, error) in
//                        if let jury = object
//                        {
//                            user.jury = jury
//                            group.leave()
//                        }
//
//                    }
//                    let result = group.wait(timeout: .now() + 5)
//                    switch result
//                    {
//                    case .success:
//                        DispatchQueue.main.async {
//                            TMPJSqliteManager.shared.saveContext()
//                            callback?(nil)
//                        }
//                    case .timedOut:
//                        DispatchQueue.main.async {
//                            self.tokenObject.token = nil
//                            self.tokenObject.user = nil
//                            TMPJSqliteManager.shared.saveContext();
//                            callback?(TMPJError.logic(info: "登录失败"))
//                        }
//                    }
//                }
//                return
//            }
//            callback?(err)
//        }
    }

}
