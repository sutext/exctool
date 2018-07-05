//
//  TMPJNetwork.swfit
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey
import Alamofire

class TMPJNetwork: AMNetwork {
    static let host = "hero.lerjin.com"
    static let shared = TMPJNetwork(baseURL: "https://\(TMPJNetwork.host)/api/v1/")
    override private init(baseURL: String) {
        super.init(baseURL: baseURL)
        self.setupHeaders()
        #if DEBUG
        self.setDebug(enable: true)
        #endif
    }
    override open var sessionConfig: URLSessionConfiguration
    {
        let config = super.sessionConfig
        config.timeoutIntervalForResource = 20;
        return config;
    }
    override var trustPolicyManager: ServerTrustPolicyManager?{
        return ServerTrustPolicyManager(policies: ["okami.lerjin.com" : ServerTrustPolicy.pinCertificates(certificates: ServerTrustPolicy.certificates(), validateCertificateChain: false, validateHost: false)])
    }
    func setup(token:String?){
        self.set(value: token, forHTTPHeaderField: "token")
    }
    func setup(account:String?){
        self.set(value: account, forHTTPHeaderField: "account")
    }
    func setupHeaders()
    {
        let device = UIDevice.current
        if let appver = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String
        {
            self.set(value: appver, forHTTPHeaderField: "appver")
        }
        self.set(value:device.identifierForVendor?.uuidString ?? "", forHTTPHeaderField: "uuid");
        self.set(value:device.systemName, forHTTPHeaderField: "appsys");
        self.set(value:device.systemVersion, forHTTPHeaderField: "sysver");
        guard global.isLogin else {
            return
        }
        self.setup(token: global.token)
        self.setup(account: global.account)
    }
}
