//
//  TMPJCollectionViewCell.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJCollectionViewCell.h"
#import "TMPJImageView.h"
#import "TMPJLabel.h"
@interface TMPJCollectionViewCell()
@property(nonatomic,strong,readwrite)TMPJImageView *imageView;
@property(nonatomic,strong,readwrite)TMPJLabel *textLabel;
@end
@implementation TMPJCollectionViewCell
-(TMPJImageView *)imageView
{
    if (!_imageView) {
        self.imageView = [[TMPJImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return _imageView;
}
-(TMPJLabel *)textLabel
{
    if (!_textLabel) {
        self.textLabel = [[TMPJLabel alloc] initWithFrame:self.bounds];
        [self addSubview:self.textLabel];
    }
    return _textLabel;
}
@end
