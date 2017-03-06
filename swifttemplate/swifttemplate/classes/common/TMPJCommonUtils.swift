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
        let regx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    func formatedMoney() ->String
    {
        return self;
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
