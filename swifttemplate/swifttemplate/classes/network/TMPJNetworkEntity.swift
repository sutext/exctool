//
//  CTNetworkEntity.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//

import EasyTools

protocol TMPJNameConvertibale
{
    var name:String!{get set}
}

protocol TMPJCategoryConvertibale : TMPJNameConvertibale
{
    associatedtype Element;
    var id:String!{get set}
    var items:[Element]?{get}
    var itemCount:Int{get}
    var expand:Bool{get set};
    init();
}

class TMPJNetworkEntity: ETNetworkEntity {
    override init(dictionary dic: [AnyHashable: Any]?)
    {
        super.init(dictionary: dic);
    }
    override convenience required init() {
        self.init(dictionary: nil);
    }
    convenience required init?(coder aDecoder: NSCoder) {
        self.init(dictionary: nil);
    }
    override func string(forKey key: String) -> String {
        if let str = super.string(forKey: key)
        {
            return str;
        }
        return "";
    }
    func countForKey(_ key:String) -> String
    {
        if let str = super.string(forKey: key)
        {
            return str;
        }
        return "0";
    }
    func floatForKey(_ key:String) -> String
    {
        if let value = Double(self.string(forKey:key))
        {
            return String(format: "%.1f", value);
        }
        return "0.0";
    }
}
