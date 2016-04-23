//
//  TMPJTableViewController.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJTableViewController.h"

@interface TMPJTableViewController ()
@property(nonatomic,strong,readwrite)TMPJTableView *tableView;
@end

@implementation TMPJTableViewController
- (void)dealloc
{
    self.tableView.delegate=nil;
    self.tableView.dataSource=nil;
}
- (instancetype)init
{
    return  [self initWithStyle:UITableViewStyleGrouped];
}
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if (self) {
        TMPJTableView *tableView=[[TMPJTableView alloc] initWithFrame:CGRectZero style:style];
        tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        tableView.showsVerticalScrollIndicator=NO;
        tableView.dataSource=self;
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        tableView.delegate=self;
        self.tableView=tableView;
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    self.tableView.frame=self.view.bounds;
    [self.view addSubview:self.tableView];
}
#pragma mark UITableViewDataSource and UITableViewDelegate  methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
