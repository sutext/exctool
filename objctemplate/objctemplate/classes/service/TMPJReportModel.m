//
//  TMPJReportModel.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJReportModel.h"
#import <objc/runtime.h>
@implementation TMPJReportModel
-(NSDictionary *)actionParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t * properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char * propertyName = property_getName(properties[i]);
        NSString *paramName = [NSString stringWithUTF8String:propertyName];
        [params setValue:[self valueForKey:paramName] forKey:paramName];
    }
    return params.count?params:nil;
}
-(NSString *)actionName
{
    return nil;
}
@end
