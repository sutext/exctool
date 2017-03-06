//
//  CTPageableRequest.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//

import EasyTools

class TMPJPageableRequest<EntityType,RequestType:RawRepresentable> : TMPJNetworkRequest<EntityType,RequestType> where RequestType.RawValue == String {
    var pageIndex:Int{
        get {
            if let str = self.param(forKey: "pageNo")
            {
                if let idx = Int(str)
                {
                    return idx;
                }
            }
            return 0
        }
        set (newval){
            self.setParam(String(newval), forKey: "pageNo");
        }
    }
    override init(type:RequestType) {
        super.init(type: type);
        self.pageIndex = 1;
        self.setParam("10", forKey: "pageSize")
    }
}
