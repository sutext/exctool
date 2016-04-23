//
//  TMPJCommonUtils.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface TMPJCommonUtils : NSObject

@end

@interface NSString(objctemplate)
-(BOOL)isPhone;
-(BOOL)isEmail;
-(BOOL)isPasswd;
-(nullable NSString *)formatedMoney;
@end

@interface NSDictionary(objctemplate)
-(nullable NSString *)stringForKey:(NSString *)key;
@end
NS_ASSUME_NONNULL_END