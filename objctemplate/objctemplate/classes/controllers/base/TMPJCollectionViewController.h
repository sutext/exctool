//
//  TMPJCollectionViewController.h
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJBaseViewController.h"
#import "TMPJCollectionView.h"
@interface TMPJCollectionViewController : TMPJBaseViewController<ETCollectionViewDelegate,UICollectionViewDataSource>
-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;
@property(nonatomic,strong,readonly)TMPJCollectionView *collectionView;
@end
