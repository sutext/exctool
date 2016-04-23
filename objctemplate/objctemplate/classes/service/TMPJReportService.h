//
//  TMPJReportService.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMPJReportModel.h"
typedef NS_OPTIONS(NSInteger, TMPJReportPlatformOptions) {
    TMPJReportPlatformNone     = 0,
    TMPJReportPlatformFlurry   = 1<<1,
    TMPJReportPlatformGoogle       = 1<<2,
    TMPJReportPlatformAll      = TMPJReportPlatformFlurry|TMPJReportPlatformGoogle
};

extern void TMPJReportAction(NSString *actionName);

extern void TMPJReportActionParams(NSString *pointNmae,NSDictionary *params);

@interface TMPJReportService : NSObject

+(instancetype)defaultService;

@property(nonatomic,readonly)TMPJReportPlatformOptions platforms;

-(void)reportModel:(TMPJReportModel *)model;

-(void)reportAction:(NSString *)actionName;

-(void)reportAction:(NSString *)actionName params:(NSDictionary *)params;

-(void)reportError:(NSError *)error errorMessage:(NSString *)message errorName:(NSString *)name;

-(void)reportException:(NSException *)exception exceptionMsg:(NSString *)message exceptionName:(NSString *)name;

@end
