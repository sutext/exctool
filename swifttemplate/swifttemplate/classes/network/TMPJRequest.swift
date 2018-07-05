//
//  TMPJRequest.swfit
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey
import Alamofire

protocol TMPJSimpleValue {
    static func value(for key:String ,in object:TMPJDynamicObject)->Self?
}
extension String:TMPJSimpleValue{
    static func value(for key: String, in object: TMPJDynamicObject) -> String? {
        return object.string(forKey: key)
    }
}
extension Bool:TMPJSimpleValue{
    static func value(for key: String, in object: TMPJDynamicObject) -> Bool? {
        return object.bool(forKey: key)
    }
}
extension Int:TMPJSimpleValue{
    static func value(for key: String, in object: TMPJDynamicObject) -> Int? {
        return object.int(forKey: key)
    }
}
extension Int64:TMPJSimpleValue{
    static func value(for key: String, in object: TMPJDynamicObject) -> Int64? {
        return object.int64(forKey: key)
    }
}
extension Double:TMPJSimpleValue{
    static func value(for key: String, in object: TMPJDynamicObject) -> Double? {
        return object.double(forKey: key)
    }
}
extension Float:TMPJSimpleValue{
    static func value(for key: String, in object: TMPJDynamicObject) -> Float? {
        return object.float(forKey: key)
    }
}
extension RawRepresentable where Self.RawValue == String{
    static func value(for key: String, in object: TMPJDynamicObject) -> Self? {
        return Self(rawValue:object.stringValue(forKey: key))
    }
}
extension RawRepresentable where Self.RawValue == Int{
    static func value(for key: String, in object: TMPJDynamicObject) -> Self? {
        return Self(rawValue:object.intValue(forKey: key))
    }
}
class TMPJRequest<DataModel>{
    private(set) var requestPath:TMPJRequestPath
    private(set) var params:Parameters
    var method:HTTPMethod
    var path:String{
        return requestPath.rawValue;
    }
    var encoding:Alamofire.ParameterEncoding
    {
        return JSONEncoding.default
    }
    init(_ path:TMPJRequestPath,method:HTTPMethod = .post,params:Parameters=[:]) {
        self.requestPath = path;
        self.params = params;
        self.method = method;
    }
    func finished(response: DataResponse<DataModel>, task: Request) {
    }
    func set(param:Any?,forKey key:String) {
        self.params[key] = param
    }
    final func transform(rawObject: Any)throws -> TMPJDynamicObject
    {
        let object = TMPJNetworkObject(rawObject)
        if object.isNull {
            throw TMPJError.service(code: .unknown, info: "服务异常")
        }
        let code = TMPJServiceCode(object.string(forKey: "code"))
        guard case .ok = code else {
            throw TMPJError.service(code: code, info: object.stringValue(forKey: "message"))
        }
        if let object = object.object(forKey: "data") {
            return object
        }
        return TMPJNetworkObject()
    }
}

extension TMPJRequest where DataModel:TMPJModel
{
    func analyze(rawObject: Any) throws -> DataModel {
        return DataModel(try self.transform(rawObject: rawObject));
    }
}
extension TMPJRequest where DataModel:RandomAccessCollection, DataModel:MutableCollection,DataModel.Element:TMPJModel
{
    func analyze(rawObject: Any) throws -> DataModel {
        let object = try self.transform(rawObject: rawObject)
        let ary = TMPJNetworkObject.map(DataModel.Iterator.Element.self, ary: object.array())
        return ary as! DataModel;
    }
}

extension TMPJRequest where DataModel==TMPJNetworkObject
{
    func analyze(rawObject: Any) throws -> DataModel {
        return DataModel(try self.transform(rawObject: rawObject));
    }
}
extension TMPJRequest where DataModel:TMPJSimpleValue
{
    func analyze(rawObject: Any) throws -> DataModel {
        let obj = try self.transform(rawObject: rawObject)
        guard let value = DataModel.value(for: self.requestPath.simplekey, in: obj) else {
            throw TMPJError.service(code: .other, info:"返回值缺少字段:"+self.requestPath.simplekey)
        }
        return value
    }
}
extension TMPJRequest where DataModel:TMPJDynamicObjectConvertible
{
    func analyze(rawObject: Any) throws -> DataModel {
        let object = try self.transform(rawObject: rawObject)
        guard let model = TMPJSqliteManager.shared.insertUpdate(DataModel.self, object: object) else{
            throw TMPJError.device(info: "存储空间已满")
        }
        return model
    }
}
extension TMPJRequest where DataModel:RandomAccessCollection, DataModel:MutableCollection,DataModel.Element:TMPJDynamicObjectConvertible
{
    func analyze(rawObject: Any) throws -> DataModel {
        let object = try self.transform(rawObject: rawObject)
        let ary = TMPJSqliteManager.shared.insertUpdate(DataModel.Element.self, objects: object.array())
        return ary as! DataModel;
    }
}
