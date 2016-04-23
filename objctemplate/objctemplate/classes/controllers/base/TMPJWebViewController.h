//
//  TMPJWebViewController.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJBaseViewController.h"
#import <WebKit/WebKit.h>
@interface TMPJWebViewController : TMPJBaseViewController
-(instancetype)initWithLink:(NSString *)weblink showToolBar:(BOOL)showToolBar;
@property(nonatomic,strong,readonly)WKWebView *webView;
@end
