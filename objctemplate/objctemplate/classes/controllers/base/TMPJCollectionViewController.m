//
//  TMPJCollectionViewController.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJCollectionViewController.h"
#import "TMPJCollectionView.h"
@interface TMPJCollectionViewController ()

@property(nonatomic,strong,readwrite)TMPJCollectionView *collectionView;
@end

@implementation TMPJCollectionViewController
- (void)dealloc
{
    self.collectionView.delegate=nil;
    self.collectionView.dataSource = nil;
}
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super init];
    if (self) {
        TMPJCollectionView *collectionView=[[TMPJCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.showsHorizontalScrollIndicator=NO;
        collectionView.delegate=self;
        collectionView.dataSource=self;
        collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        collectionView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.collectionView=collectionView;
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    self.collectionView.frame=self.view.bounds;
    [self.view addSubview:self.collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
@end
