//
//  TMPJAssetObject.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import UIKit

extension TMPJAssetObject:TMPJDynamicObjectConvertible{
    static var primaryKey: String{
        return "account"
    }
    func setup(_ model: TMPJDynamicObject) {
        
    }
}
