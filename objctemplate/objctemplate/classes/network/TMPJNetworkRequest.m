//
//  TMPJNetworkRequest.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJNetworkRequest.h"

@implementation TMPJNetworkRequest
-(id)analysisResponseObject:(id)returnedObject header:(NSDictionary *__autoreleasing  _Nullable *)header extends:(id  _Nullable __autoreleasing *)extends error:(NSError *__autoreleasing  _Nullable *)error
{
    if ([returnedObject isKindOfClass:[NSDictionary class]]) {
        id code = [returnedObject objectForKey:@"code"];
        if (code) {
            if ([code integerValue] == 200) {
                NSDictionary *headerDic = @{kETHeaderCodeKey:code,kETHeaderMeesageKey:[returnedObject objectForKey:@"message"]};
                *header = headerDic;
                return [self analyzeData:returnedObject error:error];
            }
            *error = [NSError errorWithDomain:ETNetworkErrorDomain code:ETNetworkErrorCodeNoanalyzer userInfo:@{@"message":@"data fomart error"}];
            return nil;
        }
    }
    *error = [NSError errorWithDomain:ETNetworkErrorDomain code:ETNetworkErrorCodeNoanalyzer userInfo:@{@"message":@"data fomart error"}];
    return nil;
}
-(id)analyzeData:(id)data error:(NSError *__autoreleasing *)error
{
    return data;
}
@end
