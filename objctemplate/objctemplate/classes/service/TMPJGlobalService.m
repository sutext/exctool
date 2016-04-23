//
//  TMPJAppDelegate.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJGlobalService.h"

@implementation TMPJGlobalService
+(instancetype)sharedService
{
    static dispatch_once_t onceToken;
    static TMPJGlobalService *_sharedService;
    dispatch_once(&onceToken, ^{
        _sharedService=[[super allocWithZone:nil] init];
    });
    return _sharedService;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedService];
}
@end
