//
//  TMPJNetworkManager.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import <EasyTools/EasyTools.h>

#define kTMPJNetworkServer @"www.baidu.com"
#define kTMPJNetworkTimeoutInterval 10

@interface TMPJNetworkManager : ETNetworkManager
+(instancetype)sharedManager;
@end
