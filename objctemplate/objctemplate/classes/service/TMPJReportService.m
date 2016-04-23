//
//  TMPJReportService.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJReportService.h"
//#import "Flurry.h"
inline void TMPJReportAction(NSString *actonName)
{
    [[TMPJReportService defaultService] reportAction:actonName];
}

inline void TMPJReportActionParams(NSString *actonName,NSDictionary *params)
{
    [[TMPJReportService defaultService] reportAction:actonName params:params];
}
@interface TMPJReportService()
@property(nonatomic,readwrite)TMPJReportPlatformOptions platforms;
@end
@implementation TMPJReportService

#pragma mark lifeCircle

+(instancetype)defaultService
{
    static dispatch_once_t onceToken;
    static TMPJReportService *_defaultService;
    dispatch_once(&onceToken, ^{
        _defaultService=[[super allocWithZone:nil] init];
    });
    return _defaultService;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self defaultService];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.platforms=TMPJReportPlatformFlurry;
        if (self.platforms&TMPJReportPlatformFlurry) {
            //[Flurry startSession:@"2Y6GB4M2B8H2NNHNYCX4"];
        }
#ifdef DEBUG
            //[Flurry setDebugLogEnabled:YES];
#endif
    }
    return self;
}
-(void)reportModel:(TMPJReportModel *)model
{
    if (model) {
        [self reportAction:model.actionName params:model.actionParams];
    }
}
-(void)reportAction:(NSString *)actionName
{
    [self reportAction:actionName params:nil];
}

-(void)reportAction:(NSString *)actionName params:(NSDictionary *)params
{
    if (self.platforms&TMPJReportPlatformFlurry) {
        //[Flurry logEvent:pointNmae withParameters:params];
    }
    if (self.platforms&TMPJReportPlatformGoogle) {
        //google report code hear
    }
}

-(void)reportError:(NSError *)error errorMessage:(NSString *)message errorName:(NSString *)name
{
    if (self.platforms&TMPJReportPlatformFlurry) {
        //[Flurry logError:name message:message error:error];
    }
    if (self.platforms&TMPJReportPlatformGoogle) {
        //google report code hear
    }
}

-(void)reportException:(NSException *)exception exceptionMsg:(NSString *)message exceptionName:(NSString *)name
{
    if (self.platforms&TMPJReportPlatformFlurry) {
        //[Flurry logError:name message:message exception:exception];
    }
    if (self.platforms&TMPJReportPlatformGoogle) {
        //google report code hear
    }
}
@end
