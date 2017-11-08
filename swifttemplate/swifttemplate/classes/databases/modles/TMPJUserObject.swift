//
//  TMPJUserObject.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import Airmey

extension TMPJUserObject:TMPJDynamicObjectConvertible{
    static var primaryKey: String{
        return "account"
    }
    func setup(_ model: TMPJDynamicObject) {
        
    }
}
extension TMPJUserObject{
    enum Gender :String{
        case boy = "MALE"
        case girl = "FAMALE"
    }
}
extension TMPJUserObject.Gender:AMNameConvertible,AMImageConvertible
{
    var name:String {
        get {
            switch self {
            case .boy:
                return "男"
            case .girl:
                return "女"
            }
        }
    }
    var image:UIImage?{
        switch self {
        case .boy:
            return UIImage(named:"icon_gender_boy")
        case .girl:
            return UIImage(named:"icon_gender_girl")
        }
    }
    static let all:[TMPJUserObject.Gender] = [.boy,.girl]
}
