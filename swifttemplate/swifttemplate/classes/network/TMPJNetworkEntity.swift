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
    typealias Element;
    var id:String!{get set}
    var items:[Element]?{get}
    var itemCount:Int{get}
    var expand:Bool{get set};
    init();
}

class TMPJNetworkEntity: ETNetworkEntity {
    override init(dictionary dic: [NSObject : AnyObject]?)
    {
        super.init(dictionary: dic);
    }
    override convenience required init() {
        self.init(dictionary: nil);
    }
    convenience required init?(coder aDecoder: NSCoder) {
        self.init(dictionary: nil);
    }
    override func stringForKey(key: String) -> String {
        if let str = super.stringForKey(key)
        {
            return str;
        }
        return "";
    }
    func countForKey(key:String) -> String
    {
        if let str = super.stringForKey(key)
        {
            return str;
        }
        return "0";
    }
    func floatForKey(key:String) -> String
    {
        if let value = Double(self.stringForKey(key))
        {
            return String(format: "%.1f", value);
        }
        return "0.0";
    }
}
