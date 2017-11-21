//
//  TMPJModelService.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit

final class TMPJModelService {
    static let `default` = TMPJModelService()
    private init(){}
}
extension TMPJModelService{
    func area(for user:TMPJUserObject,update:Bool = false,block:((TMPJAreaObject?,Error?) -> Void)? = nil){
        guard let id = user.areaid else {
            DispatchQueue.main.async {
                block?(nil,TMPJError.logic(info: "areaid 不存在"))
            }
            return
        }
        self.area(for: id, update: update, block: block)
    }
    func area(for id:String,update:Bool = false,block:((TMPJAreaObject?,Error?) -> Void)? = nil) {
        func request(){
            TMPJNetwork.shared.datatask(TMPJAreaRequest(info:id)) { (req, resp) in
                switch resp.result{
                case .failure(let err):
                    block?(nil,err)
                case .success(let value):
                    TMPJSqliteService.shared.insertUpdate(TMPJAreaObject.self, object: value){ (obj) in
                        block?(obj,nil)
                    }
                }
            }
        }
        if update {
            request()
            return
        }
        TMPJSqliteService.shared.query(one: TMPJAreaObject.self, for: id) { (obj) in
            if let obj = obj{
                block?(obj,nil)
                return
            }
            request()
        }
    }
    func areas(for parent:TMPJAreaObject,update:Bool = false,block:((NSOrderedSet?,Error?) -> Void)? = nil){
        guard let pid = parent.id else {
            block?(nil,TMPJError.logic(info: "数据错误"))
            return
        }
        func request(){
            TMPJNetwork.shared.datatask(TMPJAreaRequest(list:pid)) { (req, resp) in
                switch resp.result{
                case .failure(let err):
                    block?(nil,err)
                case .success(let value):
                    TMPJSqliteService.shared.insertUpdate(TMPJAreaObject.self, objects: value.array()){ (objs) in
                        let children = NSOrderedSet(array: objs)
                        parent.addToChildren(children)
                        parent.isLoaded = true
                        TMPJSqliteManager.shared.saveContext()
                        block?(children,nil)
                    }
                }
            }
        }
        if update || !parent.isLoaded{
            request()
            return
        }
        block?(parent.children,nil)
    }

}
