//
//  TMPJGlobalConfig.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMPJGlobalConfig : NSObject
+(instancetype)singleConfig;
-(void)globalConfig;
@end

#define kTMPJThemeColor ETColorFromRGBA(0x00a6eb,0.95)
