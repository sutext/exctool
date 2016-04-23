//
//  CTNetworkRequest.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//



import EasyTools

let TMPJDataFormatError = NSError(domain: ETNetworkErrorDomain, code: ETNetworkErrorCode.Business.rawValue, userInfo: ["message":"data format error"]);

class TMPJNetworkRequest<EntityType,RequestType:RawRepresentable where RequestType.RawValue == String>: ETDesignedRequest{
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
    override func finishedWithResponse(response: ETNetworkResponse, error: NSError?, task operation: NSURLSessionDataTask) {
        if error != nil
        {
            kTMPJAlertManager.showError(error!);
        }
    }
    override func analysisResponseObject(returnedObject: AnyObject, header: AutoreleasingUnsafeMutablePointer<NSDictionary?>, extends: AutoreleasingUnsafeMutablePointer<AnyObject?>) throws -> AnyObject {
        let respData:NSDictionary? = returnedObject as? NSDictionary
        guard respData != nil else
        {
            throw  TMPJDataFormatError;
        }
        
        let code:AnyObject? = respData!.objectForKey("code");
        guard code != nil else
        {
            throw TMPJDataFormatError;
        }
        
        var memery = [kETHeaderCodeKey:code!];
        if let message = respData!.objectForKey("message")
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
            throw  NSError(domain: ETNetworkErrorDomain, code: ETNetworkErrorCode.Business.rawValue, userInfo:memery);
        }
        let data = try self.analyze(respData!.objectForKey("data"));
        header.memory = memery;
        return data as! AnyObject;
    }
    func analyze(data:AnyObject?)throws -> EntityType
    {
        if let Type:TMPJNetworkEntity.Type = EntityType.self as? TMPJNetworkEntity.Type
        {
            return Type.init() as! EntityType
        }
        throw  NSError(domain: ETNetworkErrorDomain, code: ETNetworkErrorCode.Noanalyzer.rawValue, userInfo: ["message":"analyze(data:AnyObject?)throws -> EntityType must be implement"]);
    }
}
