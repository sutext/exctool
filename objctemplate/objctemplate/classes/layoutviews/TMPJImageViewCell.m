//
//  TMPJImageViewCell.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJImageViewCell.h"
#import "TMPJImageView.h"
@interface TMPJImageViewCell()
@property(nonatomic,strong,readwrite)TMPJImageView *iconView;
@end

@implementation TMPJImageViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        TMPJImageView * imageView=[[TMPJImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView addSubview:imageView];
        self.iconView=imageView;
    }
    return self;
}
@end
