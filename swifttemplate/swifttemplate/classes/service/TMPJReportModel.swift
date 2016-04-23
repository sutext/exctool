//
//  TMPJReportModel.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

protocol TMPJReportModel:NSObjectProtocol{
    var actionName:String{get}
    var actionParams:[String:String]{get}
}
