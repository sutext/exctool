//
//  TMPJBaseViewController.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objctemplate/TMPJSubviews.h>
#import <objctemplate/TMPJGlobalConfig.h>
#import <objctemplate/TMPJGlobalService.h>
#import <objctemplate/TMPJLayoutViewController.h>

@interface TMPJBaseViewController : UIViewController

@end

@interface TMPJBaseViewController (abstractMethods)
-(void)leftItemAction:(id)sender;
-(void)rightItemAction:(id)sender;
-(void)setLeftReturnIcon;
-(void)setRightBarTitle:(NSString *)title;
-(void)setLeftBarTitle:(NSString *)title;
-(void)setRightBarTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont offsetFromRight:(CGFloat)offset;

-(void)showWaitingActivity;
-(void)hideWaiting;
-(void)showAlertMessage:(NSString *)message  clickedAction:(void (^)(UIView *sender)) clickedAction;
-(void)showAlertMessage:(NSString *)message inRect:(CGRect)inRect clickedAction:(void (^)(UIView *sender)) clickedAction;
-(void)hideAlertMessage;
@end
