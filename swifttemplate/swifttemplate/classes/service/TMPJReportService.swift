//
//  TMPJReportService.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

struct TMPJReportPlatformOptions : OptionSet {
    var rawValue:UInt = 0
    init(rawValue:UInt){self.rawValue = rawValue}
    init(nilLiteral:()){rawValue = 0}
    static var None:TMPJReportPlatformOptions = [];
    static var Flury:TMPJReportPlatformOptions{
        return self.init(rawValue:1<<1)
    }
    static var Google:TMPJReportPlatformOptions{
        return self.init(rawValue:1<<2)
    }
    static var All:TMPJReportPlatformOptions = [Flury,Google];
}

func TMPJReportAction(_ actionName:String)
{
    TMPJReportService.sharedService.reportAction(actionName);
}
func TMPJReportActionParams(_ actionName:String,actionParams:[String:String]?)
{
    TMPJReportService.sharedService.reportAction(actionName, actionParams: actionParams);
}
final class TMPJReportService: NSObject {
    fileprivate var platforms:TMPJReportPlatformOptions;
    static let sharedService = TMPJReportService();
    fileprivate override init() {
        self.platforms = .All;
        super.init();
    }
    func reportModel(_ model:TMPJReportModel)
    {
        reportAction(model.actionName, actionParams: model.actionParams);
    }
    func reportAction(_ actionName:String)
    {
        reportAction(actionName, actionParams: nil);
    }
    func reportAction(_ actionName:String,actionParams:[String:String]?)
    {
        
    }
}
