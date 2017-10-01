//
//  TMPJCommonUtils.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJCommonUtils: NSObject {

}
extension String
{
    func isPhone() ->Bool
    {
        let regx = "^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    func isEmail() ->Bool
    {
        let regx = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    func isPasswd() ->Bool
    {
        let regx = "[A-Z0-9a-z]{6,16}";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    func formatedMoney() ->String
    {
        return self;
    }
    var length:Int{
        //        return self.lengthOfBytes(using: .utf8);
        return self.characters.count;
    }
    var MD5String : String
        {
        get {
            return (self as NSString).etmd5()
        }
    }
    var URLEncodeString : String
        {
        get {
            return (self as NSString).eturlEncoded()
        }
    }
    var BASE64String : String
        {
        get {
            return (self as NSString).etBase64()
        }
    }
    
}
class CTCommonUtils: NSObject {
    static func test(name:String?) -> String?
    {
        guard name != nil && name!.trimmingCharacters(in: .whitespacesAndNewlines).length>0 else
        {
            TMPJAlertManager.shared.showAlert(message: "名字不能为空")
            return nil;
        }
        guard name!.length<20 else
        {
            TMPJAlertManager.shared.showAlert(message: "名字不能太长")
            return nil;
        }
        return name!;
    }
    static func test(phone:String?) -> String?
    {
        guard (phone != nil)&&(phone!.isPhone()) else
        {
            TMPJAlertManager.shared.showAlert(message: "请输入正确手机号")
            return nil;
        }
        return phone!;
    }
    static func test(passwd:String?) -> String?
    {
        guard (passwd != nil)&&(passwd!.isPasswd()) else
        {
            TMPJAlertManager.shared.showAlert(message: "密码必须是6-16位的字母或数字的组合")
            return nil;
        }
        return passwd!;
    }
    static func test(code:String?) -> String?
    {
        guard (code != nil)&&(code!.length > 0) else
        {
            TMPJAlertManager.shared.showAlert(message: "验证码格式错误")
            return nil;
        }
        return code!;
    }
}

extension NSDictionary
{
    func stringForKey(_ key:NSString) -> NSString?
    {
        let value = self.object(forKey: key);
        if let str:NSString = value as? NSString
        {
            if str.isEqual(to: "<null>")
            {
                return nil;
            }
            return str;
        }
        if let num = value as? NSNumber
        {
            return num.stringValue as NSString?;
        }
        return nil;
    }
}
