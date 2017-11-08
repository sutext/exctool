//
//  TMPJModelService.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import UIKit

final class TMPJModelService {
    static let `default` = TMPJModelService()
    private init(){}
}
extension TMPJModelService{
    func area(for id:String,update:Bool = false,block:((TMPJAreaObject?,Error?) -> Void)? = nil) {
        func request(){
//            TMPJNetwork.shared.datatask(CKAreaRequest(info:id)) { (req, resp) in
//                switch resp.result{
//                case .failure(let err):
//                    block?(nil,err)
//                case .success(let value):
//                    CKSqliteService.shared.insertUpdate(CKAreaObject.self, object: value){ (obj) in
//                        block?(obj,nil)
//                    }
//                }
//            }
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

    func areas(for parent:TMPJAreaObject?,update:Bool = false,block:(([TMPJAreaObject]?,Error?) -> Void)? = nil){
        var pid = parent?.id
        if pid == nil {
            pid = "0"
        }
        func request(){
//            CKNetwork.karaok.datatask(CKAreaRequest(list:pid!)) { (req, resp) in
//                switch resp.result{
//                case .failure(let err):
//                    block?(nil,err)
//                case .success(let value):
//                    CKSqliteService.shared.insertUpdate(CKAreaObject.self, objects: value.array()){ (objs) in
//                        if let pobj = parent{
//                            pobj.addToChildren(NSOrderedSet(array: objs))
//                            CKSqliteManager.shared.saveContext()
//                        }
//                        block?(objs,nil)
//                    }
//                }
//            }
        }
        if update{
            request()
            return
        }
        if let pobj = parent {
            if let objects = pobj.children?.array as? [TMPJAreaObject],objects.count>0{
                block?(objects,nil)
                return
            }
            request()
            return
        }
        let predicate = NSPredicate(format: "pid=0")
        TMPJSqliteService.shared.query(list: TMPJAreaObject.self, predicate: predicate) { (objects) in
            if objects.count > 0{
                block?(objects,nil)
                return
            }
            request()
        }
    }

}
