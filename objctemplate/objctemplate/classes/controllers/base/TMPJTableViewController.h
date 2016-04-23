//
//  TMPJTableViewController.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJBaseViewController.h"
#import "TMPJTableView.h"
@interface TMPJTableViewController : TMPJBaseViewController<ETTableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong,readonly)TMPJTableView *tableView;
- (instancetype)init;//default is UITableViewStyleGrouped;
- (instancetype)initWithStyle:(UITableViewStyle)style;
@end
