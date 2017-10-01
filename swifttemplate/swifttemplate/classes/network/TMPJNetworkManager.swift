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
    fileprivate override init() {
        super.init(baseURL: "https://\(kTMPJNetworkServer)/teahouse/", monitorName: kTMPJNetworkServer, timeoutInterval: kTMPJNetworkTimeoutInterval);
        self.setDebugEnable(true);
        self.setupHeaders();
    }
    func setupHeaders()
    {
        let device = UIDevice.current
        if let appver = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
        {
            self.setValue(appver, forHTTPHeaderField: "appver");
        }
        self.setValue(device.identifierForVendor?.uuidString, forHTTPHeaderField: "uuid");
        self.setValue(device.systemName, forHTTPHeaderField: "appsys");
        self.setValue(device.systemVersion, forHTTPHeaderField: "sysver");
    }
    func datatask<Resp,Type:RawRepresentable,Req:TMPJNetworkRequest<Resp,Type>>(_ request: Req, completedBlock: ((_ reqest:Req?,_ data:Resp?, _ error:Error?) -> Void)?) -> URLSessionDataTask? where Type.RawValue == String {
        return self.datatask(with:request, completedBlock: { (req : ETNetworkRequest?,resp: ETNetworkResponse?, error:Error?) -> Void in
            if let compl = completedBlock
            {
                compl(req as? Req,resp?.entiyObject as? Resp,error);
            }
        });
    }
    func upload<Resp,Type:RawRepresentable,Req:TMPJNetworkRequest<Resp,Type>>(_ request: Req, completedBlock: ((_ reqest:Req?,_ data:Resp?, _ error:Error?) -> Void)?) -> URLSessionDataTask? where Type.RawValue == String,Req:ETUploadProtocol {
        return self.upload(withRequest:request, progress: nil, completedBlock: { (req : ETNetworkRequest?,resp: ETNetworkResponse?, error:Error?) -> Void in
            if let compl = completedBlock
            {
                compl(req as? Req,resp?.entiyObject as? Resp,error);
            }
        })
    }


}
