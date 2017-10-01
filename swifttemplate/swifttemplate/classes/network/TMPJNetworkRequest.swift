//
//  CTNetworkRequest.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//



import EasyTools

let TMPJDataFormatError = NSError(domain: ETNetworkErrorDomain, code: ETNetworkErrorCode.business.rawValue, userInfo: ["message":"data format error"]);

class TMPJNetworkRequest<EntityType,RequestType:RawRepresentable>: ETDesignedRequest where RequestType.RawValue == String{
    var requestType:RequestType!
    init(type:RequestType) {
        super.init();
        self.requestType = type;
    }
    override func requestURL() -> String {
        return self.requestType!.rawValue;
    }
    override func requestMethod() -> ETNetworkRequestMethod {
        return .POST;
    }
    func finished(with response: ETNetworkResponse, error: Error?, task taskOperator: URLSessionUploadTask){
        if error != nil
        {
            TMPJAlertManager.shared.showError(error! as NSError);
        }
    }
    override func analysisResponseObject(_ returnedObject: Any, header: AutoreleasingUnsafeMutablePointer<NSDictionary?>?, extends: AutoreleasingUnsafeMutablePointer<AnyObject?>?) throws -> Any {
        let respData:NSDictionary? = returnedObject as? NSDictionary
        guard respData != nil else
        {
            throw  TMPJDataFormatError;
        }
        
        let code:AnyObject? = respData!.object(forKey: "code") as AnyObject?;
        guard code != nil else
        {
            throw TMPJDataFormatError;
        }
        
        var memery:[AnyHashable : Any] = [kETHeaderCodeKey:code!];
        if let message = respData!.object(forKey: "message")
        {
            memery[kETHeaderMeesageKey] = message;
        }
        else
        {
            memery[kETHeaderMeesageKey] = "";
        }
        let errorCode = code!.integerValue;
        guard errorCode == 200 else
        {
            throw  NSError(domain: ETNetworkErrorDomain, code: ETNetworkErrorCode.business.rawValue, userInfo:memery);
        }
        let data = try self.analyze(respData!.object(forKey: "data"));
        header?.pointee = memery as NSDictionary;
        return data as AnyObject;
    }
    func analyze(_ data:Any?)throws -> Any
    {
        return NSNull();
    }
}
