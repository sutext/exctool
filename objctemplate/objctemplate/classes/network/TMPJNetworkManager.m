//
//  TMPJNetworkManager.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJNetworkManager.h"

@implementation TMPJNetworkManager
+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static TMPJNetworkManager *_deafaultManager;
    dispatch_once(&onceToken, ^{
        _deafaultManager=[[super allocWithZone:nil] init];
    });
    return _deafaultManager;
}
- (instancetype)init
{
    self = [super initWithBaseURL:[NSString stringWithFormat:@"http://%@/",kTMPJNetworkServer] monitorName:kTMPJNetworkServer timeoutInterval:kTMPJNetworkTimeoutInterval];
    if (self) {
#if DEBUG
        [self setDebugEnable:YES];
#endif
    }
    return self;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
