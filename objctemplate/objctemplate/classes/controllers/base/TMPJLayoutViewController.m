//
//  TMPJLayoutViewController.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJLayoutViewController.h"
#import "TMPJMainViewController.h"
#import "TMPJLeftSideController.h"
@interface TMPJLayoutViewController ()

@end

@implementation TMPJLayoutViewController
+(instancetype)sharedController
{
    static dispatch_once_t onceToken;
    static TMPJLayoutViewController *_sharedController;
    dispatch_once(&onceToken, ^{
        TMPJMainViewController *main=[[TMPJMainViewController alloc] init];
        TMPJLeftSideController *left = [[TMPJLeftSideController alloc] init];
        _sharedController=[[self alloc] initWithRootViewController:[[UINavigationController alloc] initWithRootViewController:main]];
        _sharedController.leftViewController=left;
        _sharedController.rightViewController = [[TMPJLeftSideController alloc] init];
    });
    return _sharedController;
}
-(UIViewController *)childViewControllerForStatusBarStyle
{
    return [(UINavigationController *)self.rootViewController topViewController];
}
-(UIViewController *)childViewControllerForStatusBarHidden
{
    return [(UINavigationController *)self.rootViewController topViewController];
}
@end
