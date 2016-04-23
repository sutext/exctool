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
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluateWithObject(self);
    }
    func isEmail() ->Bool
    {
        let regx = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluateWithObject(self);
    }
    func isPasswd() ->Bool
    {
        let regx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluateWithObject(self);
    }
    func formatedMoney() ->String
    {
        return self;
    }
    var MD5String : String
        {
        get {
            return (self as NSString).ETMD5String()
        }
    }
    var URLEncodeString : String
        {
        get {
            return (self as NSString).ETURLEncodedString()
        }
    }
    var BASE64String : String
        {
        get {
            return (self as NSString).ETBase64String()
        }
    }
    
}

extension NSDictionary
{
    func stringForKey(key:NSString) -> NSString?
    {
        let value = self.objectForKey(key);
        if let str:NSString = value as? NSString
        {
            if str.isEqualToString("<null>")
            {
                return nil;
            }
            return str;
        }
        if let num = value as? NSNumber
        {
            return num.stringValue;
        }
        return nil;
    }
}