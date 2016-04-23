//
//  TMPJMainViewController.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJMainViewController.h"
#import "TMPJWebViewController.h"
@interface TMPJMainViewController ()

@end

@implementation TMPJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showAlertMessage:@"点击跳转" clickedAction:^(UIView *sender) {
        [self.navigationController pushViewController:[[TMPJWebViewController alloc] initWithLink:@"http://www.baidu.com" showToolBar:YES] animated:YES];
    }];
    [self setLeftReturnIcon];
    [self setRightBarTitle:@"test"];
}

-(void)leftItemAction:(id)sender
{
    [[TMPJLayoutViewController sharedController] showLeftViewController:YES];
}
-(void)rightItemAction:(id)sender
{
    [[TMPJLayoutViewController sharedController] showRightViewController:YES];
}
@end
