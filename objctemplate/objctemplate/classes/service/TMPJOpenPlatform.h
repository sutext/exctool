//
//  TMPJOpenPlatform.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, TMPJPlatformErrorType) {
    TMPJPlatformErrorTypeUnknown,
    TMPJPlatformErrorTypeSucceed,
    TMPJPlatformErrorTypeNetwork,
    TMPJPlatformErrorTypeCancel,
    TMPJPlatformErrorTypeRefuse,
    TMPJPlatformErrorTypeNotInstall,
    TMPJPlatformErrorTypeUnsuport,
    TMPJPlatformErrorTypeException,
};

typedef NS_ENUM(NSUInteger, TMPJOpenPlatformType) {
    TMPJOpenPlatformTypeUnknown,
    TMPJOpenPlatformTypeQQ,
    TMPJOpenPlatformTypeQQZone,
    TMPJOpenPlatformTypeWeChat,
    TMPJOpenPlatformTypeWeChatMoments,
    TMPJOpenPlatformTypeWeibo,
};

typedef NS_ENUM(NSUInteger, TMPJPlatformAuthType) {
    TMPJPlatformAuthTypeUnknown,
    TMPJPlatformAuthTypeQQ,
    TMPJPlatformAuthTypeWeChat,
    TMPJPlatformAuthTypeWeibo,
};

@interface TMPJOpenPlatformMedia : NSObject

@end

@interface TMPJOpenPlatform : NSObject
+(instancetype)sharedPlatform;
-(void)configPlatform;
-(BOOL)handleOpenURL:(NSURL *)url;
-(void)authWithType:(TMPJPlatformAuthType)platform
      completeBlock:(void (^)(TMPJPlatformAuthType authType,NSString *openid,NSDictionary *userinfo,TMPJPlatformErrorType type)) completeBlock;
-(void)shareMediaObject:(TMPJOpenPlatformMedia *)mediaObject completedBlock:(void (^)(TMPJPlatformErrorType errorCode,TMPJOpenPlatformMedia *mediaObject)) completedBlock;
@end
