//
//  TMPJOpenPlatform.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJOpenPlatform.h"

@implementation TMPJOpenPlatform
#pragma mark lifeCircle
+(instancetype)sharedPlatform
{
    static dispatch_once_t onceToken;
    static TMPJOpenPlatform *_sharedPlatform;
    dispatch_once(&onceToken, ^{
        _sharedPlatform=[[super allocWithZone:nil] init];
    });
    return _sharedPlatform;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedPlatform];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)configPlatform
{
    
}
-(BOOL)handleOpenURL:(NSURL *)url
{
    return NO;
}
-(void)authWithType:(TMPJPlatformAuthType)platform completeBlock:(void (^)(TMPJPlatformAuthType, NSString *, NSDictionary *, TMPJPlatformErrorType))completeBlock
{
};
-(void)shareMediaObject:(TMPJOpenPlatformMedia *)mediaObject completedBlock:(void (^)(TMPJPlatformErrorType, TMPJOpenPlatformMedia *))completedBlock
{
};
@end
