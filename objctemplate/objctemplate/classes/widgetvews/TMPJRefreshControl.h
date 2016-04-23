//
//  TMPJRefreshControl.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import <EasyTools/EasyTools.h>

@interface TMPJRefreshControl : UIView<ETRefreshProtocol>
@property (nonatomic, getter=isEnabled) BOOL enabled;
@end
