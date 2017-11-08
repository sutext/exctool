//
//  TMPJCommonUtils.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import UIKit
import Airmey

extension String
{
    var isPhone:Bool{
        let regx = "^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    var isEmail:Bool{
        let regx = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    var isPasswd:Bool{
        let regx = "[A-Z0-9a-z]{6,16}";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    var isNickName:Bool{
        let regx = "[A-Z0-9a-z\\u4e00-\\u9fa5]{1,8}";
        return NSPredicate(format: "SELF MATCHES %@", regx).evaluate(with: self);
    }
    func formatedMoney() ->String
    {
        return self;
    }
    var length:Int{
        return self.count;
    }
    var md5 : String{
        get {
            return MD5String(self).uppercased()
        }
    }
    func height(width:CGFloat,font:UIFont = .size14) -> CGFloat {
        return self.size(with: CGSize(width:width,height:10000), font: font).height;
    }
    func size(with size:CGSize,font:UIFont) -> CGSize {
        return (self as NSString).boundingRect(with: size, options:[.usesLineFragmentOrigin,.usesFontLeading],attributes: [.font:font],context: nil).size;
    }
}
class TMPJCommonUtils: NSObject {
    static func test(name:String?) -> String?
    {
        guard name != nil && name!.trimmingCharacters(in: .whitespacesAndNewlines).length>0 else
        {
            popup.alert(message: "昵称不能为空")
            return nil;
        }
        guard name!.length<8 else
        {
            popup.alert(message: "昵称不能太长")
            return nil;
        }
        guard name!.isNickName else {
            popup.alert(message: "昵称不能含有特殊字符")
            return nil
        }
        return name!;
    }
    static func test(phone:String?) -> String?
    {
        guard (phone != nil)&&(phone!.isPhone) else
        {
            popup.alert(message: "请输入正确手机号")
            return nil;
        }
        return phone!;
    }
    static func test(passwd:String?) -> String?
    {
        guard (passwd != nil)&&(passwd!.isPasswd) else
        {
            popup.alert(message: "密码必须是6-16位的字母或数字的组合")
            return nil;
        }
        return passwd!;
    }
    static func test(code:String?) -> String?
    {
        guard (code != nil)&&(code!.length > 0) else
        {
            popup.alert(message: "验证码格式错误")
            return nil;
        }
        return code!;
    }
}
