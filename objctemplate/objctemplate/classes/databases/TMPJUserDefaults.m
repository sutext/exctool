//
//  TMPJUserDefaults.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJUserDefaults.h"

@implementation TMPJUserDefaults
+(instancetype)standardDefaults
{
    static dispatch_once_t onceToken;
    static TMPJUserDefaults *_standardDefaults;
    dispatch_once(&onceToken, ^{
        _standardDefaults=[[super allocWithZone:nil] init];
    });
    return _standardDefaults;
}
@end
