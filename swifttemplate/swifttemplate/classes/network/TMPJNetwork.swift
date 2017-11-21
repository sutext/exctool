//
//  TMPJNetwork.swfit
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJNetwork: AMNetwork {
    #if DEBUG
    static let shared = TMPJNetwork(baseURL: "http://dev.icegent.swifttemplate.com/v1/")
    #else
    static let shared = TMPJNetwork(baseURL: "http://api.icegent.swifttemplate.com/v1/")
    #endif
    override private init(baseURL: String) {
        super.init(baseURL: baseURL);
        self.setupHeaders();
        self.setDebug(enable: global.isDebug);
    }
    override open var sessionConfig: URLSessionConfiguration
        {
        let config = super.sessionConfig
        config.timeoutIntervalForResource = 20;
        return config;
    }
    func setupHeaders()
    {
        if let token = global.token
        {
            self.set(value: token, forHTTPHeaderField: "token");
        }
        let device = UIDevice.current
        if let appver = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
        {
            self.set(value: appver, forHTTPHeaderField: "appver")
        }
        self.set(value:device.identifierForVendor?.uuidString ?? "", forHTTPHeaderField: "uuid");
        self.set(value:device.systemName, forHTTPHeaderField: "appsys");
        self.set(value:device.systemVersion, forHTTPHeaderField: "sysver");
    }
}
