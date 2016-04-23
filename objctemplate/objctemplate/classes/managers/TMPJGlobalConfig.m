//
//  TMPJGlobalConfig.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJGlobalConfig.h"
#import <EasyTools/EasyTools.h>
@implementation TMPJGlobalConfig
+(instancetype)singleConfig
{
    static dispatch_once_t onceToken;
    static TMPJGlobalConfig *_singleConfig;
    dispatch_once(&onceToken, ^{
        _singleConfig=[[super allocWithZone:nil] init];
    });
    return _singleConfig;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self singleConfig];
}
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
-(void)globalConfig
{
    UINavigationBar *navbar = [UINavigationBar appearance];
    [navbar setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(1, 1)]];
    [navbar setBackgroundImage:[UIImage imageWithColor:kTMPJThemeColor size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    [navbar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
@end
