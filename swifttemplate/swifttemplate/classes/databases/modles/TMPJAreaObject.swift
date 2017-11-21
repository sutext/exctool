//
//  TMPJAreaObject.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import UIKit

extension TMPJAreaObject: TMPJDynamicObjectConvertible {
    static var primaryKey: String{
        return "id"
    }
    func setup(_ model: TMPJDynamicObject) {
        if let str = model.string(forKey: "pid"){
            self.pid = str
        }
        if let str = model.string(forKey: "shortName"){
            self.shortName = str
        }
        if let str = model.string(forKey: "name"){
            self.name = str
        }
        if let str = model.string(forKey: "longName"){
            self.fullName = str
        }
        if let str = model.string(forKey: "level"){
            self.level = str
        }
        if let str = model.string(forKey: "pinyin"){
            self.pinyin = str
        }
        if let str = model.string(forKey: "code"){
            self.areaCode = str
        }
        if let str = model.string(forKey: "zipCode"){
            self.postCode = str
        }
        if let str = model.string(forKey: "initialLetter"){
            self.initial = str
        }
    }
}
extension TMPJAreaObject{
    static private(set) var root:TMPJAreaObject = {
        if let root = TMPJSqliteManager.shared.query(one: TMPJAreaObject.self, for: "0"){
            return root
        }
        let root = TMPJSqliteManager.shared.generateObject(TMPJAreaObject.self, keyValue: "0")
        root.fullName = "中国"
        root.pinyin = "zhongguo"
        root.initial = "Z"
        root.shortName = "中国"
        root.areaCode = "+86"
        root.name = "中国"
        TMPJSqliteManager.shared.saveContext()
        return root
    }()
}
