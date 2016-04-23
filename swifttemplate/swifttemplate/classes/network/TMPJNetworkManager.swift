//
//  TMPJNetworkManager.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools
let kTMPJNetworkServer = "www.baidu.com"
let kTMPJNetworkTimeoutInterval = 10.0

let kTMPJNetworkManager = TMPJNetworkManager();
class TMPJNetworkManager: ETNetworkManager {
    private override init() {
        super.init(baseURL: "https://\(kTMPJNetworkServer)/teahouse/", monitorName: kTMPJNetworkServer, timeoutInterval: kTMPJNetworkTimeoutInterval);
        self.setDebugEnable(true);
        self.setupHeaders();
    }
    func setupHeaders()
    {
        let device = UIDevice.currentDevice()
        if let appver = NSBundle.mainBundle().infoDictionary?[kCFBundleVersionKey as String] as? String
        {
            self.setValue(appver, forHTTPHeaderField: "appver");
        }
        self.setValue(device.identifierForVendor?.UUIDString, forHTTPHeaderField: "uuid");
        self.setValue(device.systemName, forHTTPHeaderField: "appsys");
        self.setValue(device.systemVersion, forHTTPHeaderField: "sysver");
    }
    func datatask<C,T:RawRepresentable,R:TMPJNetworkRequest<C,T> where T.RawValue == String>(request: R, completedBlock: ((reqest:R?,data:C?, error:NSError?) -> Void)?) -> NSURLSessionDataTask? {
        return self.datataskWithRequest(request, completedBlock: { (req : ETNetworkRequest?,resp: ETNetworkResponse?, error:NSError?) -> Void in
            if let compl = completedBlock
            {
                compl(reqest: req as? R,data: resp?.entiyObject as? C,error: error);
            }
        });
    }
    func upload<C,T:RawRepresentable,R:TMPJNetworkRequest<C,T> where T.RawValue == String,R:ETUploadProtocol>(request: R, completedBlock: ((reqest:R?,data:C?, error:NSError?) -> Void)?) -> NSURLSessionDataTask? {
        return self.uploadWithRequest(request, progress: nil, completedBlock: { (req : ETNetworkRequest?,resp: ETNetworkResponse?, error:NSError?) -> Void in
            if let compl = completedBlock
            {
                compl(reqest: req as? R,data: resp?.entiyObject as? C,error: error);
            }
        })
    }

}
