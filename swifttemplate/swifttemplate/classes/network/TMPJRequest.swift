//
//  TMPJRequest.swfit
//  swifttemplate
//
//  Created by supertext on 2017/6/28.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey
import Alamofire

class TMPJRequest<DataModel>{
    private(set) var requestPath:TMPJRequestPath
    private(set) var params:Parameters
    var method:HTTPMethod
    
    var path:String{
        return requestPath.rawValue;
    }
    var encoding:Alamofire.ParameterEncoding
    {
        if self.method == .get {
            return URLEncoding.queryString
        }
        return JSONEncoding.default
    }
    init(_ path:TMPJRequestPath,method:HTTPMethod = .post,params:Parameters=[:]) {
        self.requestPath = path;
        self.params = params;
        self.method = method;
    }
    func finished(response: DataResponse<DataModel>, task: Request) {
        if let error = response.error
        {
            switch error {
            case TMPJError.service(205, _):
                if self.requestPath.rawValue != TMPJRequestPath.Auth.logout.rawValue{
                    global.logout()
                }
                
            default:
                popup.remind(.error(error))
            }
        }
    }
    func set(param:Any?,forKey key:String) {
        self.params[key] = param
    }
    final func transform(rawObject: Any)throws -> TMPJDynamicObject
    {
        let object = TMPJNetworkObject(rawObject)
        if object.isNull {
            throw TMPJError.service(code: -1, info: "服务异常")
        }
        guard let errorCode = object.int(forKey: "code") else {
            throw TMPJError.service(code: -1, info: "服务异常")
        }
        guard errorCode == 200 else {
            throw TMPJError.service(code: errorCode, info: object.stringValue(forKey: "message"))
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
extension TMPJRequest where DataModel==TMPJNetworkObject
{
    func analyze(rawObject: Any) throws -> DataModel {
        return DataModel(try self.transform(rawObject: rawObject));
    }
}
extension TMPJRequest where DataModel:RandomAccessCollection, DataModel:MutableCollection,DataModel.Iterator.Element:TMPJModel
{
    func analyze(rawObject: Any) throws -> DataModel {
        let object = try self.transform(rawObject: rawObject)
        let ary = TMPJNetworkObject.map(DataModel.Iterator.Element.self, ary: object.array())
        return ary as! DataModel;
    }
}
class TMPJCommonRequest: TMPJRequest<TMPJNetworkObject>,AMDataRequest{
    
}

