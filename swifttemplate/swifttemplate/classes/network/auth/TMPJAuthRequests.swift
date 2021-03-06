//
//  TMPJAuthRequests.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

struct TMPJAuth {private init(){}}
extension TMPJAuth{
    enum ThirdPlatform:String
    {
        case qq="QQ";
        case wechat = "WECHAT";
        case weibo = "WEIBO";
    }
    enum SMSCodeUsing :String{
        case register = "REGISTER"
        case resetpwd = "RESET_PASSWORD"
    }
    class ThirdModel: TMPJModel {
        var isNull: Bool
        var avatar:String!
        var nickname:String!
        var gender:TMPJUserObject.Gender?
        var platform:ThirdPlatform?
        required init(_ entity: TMPJDynamicObject) {
            self.isNull = entity.isNull
            guard !self.isNull else {
                return
            }
            self.avatar = entity.stringValue(forKey: "avatar");
            self.platform = ThirdPlatform(rawValue:entity.stringValue(forKey: "platform"));
            self.gender = TMPJUserObject.Gender(rawValue: entity.stringValue(forKey: "gender"));
            self.nickname = entity.string(forKey: "nickname");
        }
    }
    class ThirdRequest: TMPJRequest<TMPJNetworkObject>,AMDataRequest{
        init(delete platform: ThirdPlatform) {
            super.init(.third(.delete))
            self.set(param: platform.rawValue, forKey: "platform")
        }
        init(add platform:ThirdPlatform,code:String) {
            super.init(.third(.add))
            self.set(param: platform.rawValue, forKey: "platform")
            self.set(param: code, forKey: "code")
        }
    }
    class ThirdListRequest: TMPJRequest<[ThirdModel]>,AMDataRequest{
        init(_ account:String? = nil){
            super.init(.third(.list))
            self.set(param: account, forKey: "account")
            self.method = .get
        }
    }
    class Request: TMPJRequest<TMPJNetworkObject> ,AMDataRequest {
        private init(_ path: TMPJRequestPath.Auth) {
            super.init(.auth(path))
        }
        convenience init(login phone:String,passwd:String){
            self.init(.login)
            self.set(param:phone, forKey: "phone");
            self.set(param:passwd.md5, forKey: "password");
        }
        convenience init(login platform:ThirdPlatform,code:String){
            self.init(.third)
            self.set(param:platform.rawValue, forKey: "platform");
            self.set(param:code, forKey: "code");
        }
        convenience init(register passwd:String,phone:String,code:String){
            self.init(.register)
            self.set(param:phone, forKey: "phone");
            self.set(param:code, forKey: "code");
            self.set(param:passwd.md5, forKey: "password");
        }
        convenience init(resetpwd passwd:String,phone:String,code:String)
        {
            self.init(.resetpwd)
            self.set(param: phone, forKey: "phone")
            self.set(param: code, forKey: "code")
            self.set(param: passwd.md5, forKey: "password")
        }
        convenience init(sendCode using:SMSCodeUsing, phone:String)
        {
            self.init(.sendCode)
            self.set(param: using.rawValue, forKey: "type")
            self.set(param: phone, forKey: "phone")
        }
        convenience init(verifyCode code:String , phone:String)
        {
            self.init(.verifyCode)
            self.set(param:code, forKey: "code")
            self.set(param:phone, forKey: "phone")
        }
    }
    class LogoutRequest: TMPJRequest<TMPJNetworkObject> ,AMDataRequest {
        init() {
            super.init(.auth(.logout))
        }
    }
}
class TMPJAreaRequest:TMPJRequest<TMPJNetworkObject> ,AMDataRequest{
    init(list pid:String){
        super.init(.other(.areaList),method: .get)
        self.set(param: pid, forKey: "pid")
    }
    init(info id:String){
        super.init(.other(.area),method: .get)
        self.set(param: id, forKey: "id")
    }
}
