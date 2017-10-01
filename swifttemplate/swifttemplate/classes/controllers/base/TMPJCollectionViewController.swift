//
//  TMPJCollectionViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJCollectionViewController: TMPJBaseViewController,ETCollectionViewDelegate,UICollectionViewDataSource{
    var collectionView:TMPJCollectionView
    convenience override init()
    {
        self.init(collectionViewLayout:UICollectionViewFlowLayout());
    }
    init(collectionViewLayout:UICollectionViewLayout)
    {
        self.collectionView = TMPJCollectionView(frame: CGRect.zero,collectionViewLayout:collectionViewLayout);
        super.init();
        self.collectionView.showsHorizontalScrollIndicator=false;
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.keyboardDismissMode = .onDrag;
        self.collectionView.autoresizingMask=[.flexibleWidth,.flexibleHeight];
    }
    deinit
    {
        self.collectionView.delegate = nil;
        self.collectionView.dataSource = nil;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.collectionView.frame = self.view.bounds;
        self.view.addSubview(self.collectionView);
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell();
    }
}
