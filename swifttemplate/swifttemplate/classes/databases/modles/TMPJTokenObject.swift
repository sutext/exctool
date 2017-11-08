//
//  TMPJTokenObject.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import UIKit

extension TMPJTokenObject:TMPJDynamicObjectConvertible{
    static let pkeyValue:String = "com.icegent.token.primaryKey.value"
    static var primaryKey: String{
        return "pkey"
    }
    func setup(_ model: TMPJDynamicObject) {
        
    }
}
