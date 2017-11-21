//
//  TMPJAssetObject.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
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
