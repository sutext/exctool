//
//  TMPJBaseViewController.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJBaseViewController.h"
#import "TMPJLabel.h"
#import <EasyTools/EasyTools.h>
@interface TMPJBaseViewController ()
@property(nonatomic,strong)ETTapView *overlyView;
@property(nonatomic,strong)UIActivityIndicatorView *waitingActivity;
@end

@implementation TMPJBaseViewController
-(UIActivityIndicatorView *)waitingActivity
{
    if (!_waitingActivity) {
        self.waitingActivity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.waitingActivity.center=CGPointMake(self.view.width/2,self.view.height/2 );
    }
    return _waitingActivity;
}
-(void)setLeftReturnIcon
{
    ETNavigationBarItem *item = [ETNavigationBarItem itemWithImage:[UIImage arrowWithColor:[UIColor whiteColor] direction:ETArrowImageDirectionLeft size:CGSizeMake(20, 20) scale:2] selectedImage:nil action:@selector(leftItemAction:)];
    [self setLeftBarItems:@[item,[ETNavigationBarItem itemWithFixed:-10]]];
}
-(void)leftItemAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightItemAction:(id)sender
{

}
-(void)setRightBarTitle:(NSString *)title
{
    [self setRightBarTitle:title titleColor:[UIColor whiteColor] titleFont:nil offsetFromRight:-10 ];
}
-(void)setLeftBarTitle:(NSString *)title
{
    [self setLeftBarTitle:title titleColor:[UIColor whiteColor] titleFont:nil offsetFromLeft:-10];
}
-(void)setLeftBarTitle:(NSString *)title titleColor:(nullable UIColor *)titleColor titleFont:(nullable UIFont *)titleFont offsetFromLeft:(CGFloat)offset
{
    ETNavigationBarItem *item = [ETNavigationBarItem itemWithTitle:title action:@selector(leftItemAction:)];
    item.titleFont =titleFont;
    item.titleColor=titleColor;
    [self setLeftBarItems:@[item,[ETNavigationBarItem itemWithFixed:offset]]];
}
-(void)setRightBarTitle:(NSString *)title titleColor:(nullable UIColor *)titleColor titleFont:(nullable UIFont *)titleFont offsetFromRight:(CGFloat)offset
{
    ETNavigationBarItem *item = [ETNavigationBarItem itemWithTitle:title action:@selector(rightItemAction:)];
    item.titleFont =titleFont;
    item.titleColor=titleColor;
    [self setRightBarItems:@[item,[ETNavigationBarItem itemWithFixed:offset]]];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)showWaitingActivity
{
    if (!self.waitingActivity.superview) {
        [self.view addSubview:self.waitingActivity];
        [self.waitingActivity startAnimating];
    }
}
-(void)hideWaiting
{
    [self.waitingActivity stopAnimating];
    [self.waitingActivity removeFromSuperview];
    self.waitingActivity=nil;
}

-(void)showAlertMessage:(NSString *)message  clickedAction:(void (^)(UIView *sender)) clickedAction
{
    [self showAlertMessage:message inRect:self.view.bounds clickedAction:clickedAction];
}
-(void)showAlertMessage:(NSString *)message inRect:(CGRect)inRect clickedAction:(void (^)(UIView *sender)) clickedAction;
{
    if (message.length) {
        if (self.overlyView) {
            [self removeAlert];
        }
        ETTapView *overlay=[[ETTapView alloc] initWithFrame:inRect];
        overlay.backgroundColor=[UIColor whiteColor];
        
        UILabel *textLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, inRect.size.height/2-25, inRect.size.width-20, 50)];
        textLabel.font=[UIFont systemFontOfSize:16];
        textLabel.numberOfLines=2;
        textLabel.textAlignment=NSTextAlignmentCenter;
        textLabel.backgroundColor=[UIColor clearColor];
        textLabel.textColor=ETColorFromRGB(0x677386);
        textLabel.text = message;
        [overlay addSubview:textLabel];
        if (clickedAction) {
            overlay.tapAction=clickedAction;
        }
        self.overlyView=overlay;
        [self.view addSubview:self.overlyView];
    }
}
-(void)removeAlert
{
    if (self.overlyView) {
        [self.overlyView removeFromSuperview];
        self.overlyView=nil;
    }
}
@end
