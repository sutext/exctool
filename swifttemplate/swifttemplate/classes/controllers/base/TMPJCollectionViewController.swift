//
//  TMPJCollectionViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//
import Airmey

class TMPJCollectionViewController: TMPJBaseViewController{
    let collectionView:TMPJCollectionView
    var contentInsets:AMConstraintInsets!
    convenience override init()
    {
        self.init(collectionViewLayout:UICollectionViewFlowLayout());
    }
    init(collectionViewLayout:UICollectionViewLayout)
    {
        self.collectionView = TMPJCollectionView(frame: CGRect.zero,collectionViewLayout:collectionViewLayout);
        super.init();
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.backgroundColor = UIColor.white;
    }
    deinit
    {
        self.collectionView.delegate = nil;
        self.collectionView.dataSource = nil;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.addSubview(self.collectionView)
        let left = self.collectionView.adhere(left: nil)
        let right = self.collectionView.adhere(right: nil)
        let top = self.collectionView.topAnchor.equal(to: self.topLayoutGuide.bottomAnchor)
        let bottom = self.collectionView.bottomAnchor.equal(to: self.bottomLayoutGuide.topAnchor)
        self.contentInsets = AMConstraintInsets(top: top, left: left, bottom: bottom, right: right)
    }
    func loadMore()  {
        
    }
}

extension TMPJCollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return TMPJCollectionViewCell()
    }
}
extension TMPJCollectionViewController:AMCollectionViewDelegate
{
    func collectionView(_ tableView: AMCollectionView, willBeginRefreshWithStyle style: AMRefreshStyle, refreshControl: AMRefreshProtocol) {
        switch style {
        case .top:
            self.reloadData()
        case .bottom:
            self.loadMore()
        }
    }
}
