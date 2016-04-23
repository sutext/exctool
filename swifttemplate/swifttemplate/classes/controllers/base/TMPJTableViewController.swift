//
//  TMPJTableViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools

class TMPJTableViewController: TMPJBaseViewController,ETTableViewDelegate,UITableViewDataSource{
    var tableView : TMPJTableView
    override convenience init() {
        self.init(style:.Plain);
    }
    init(style:UITableViewStyle) {
        self.tableView=TMPJTableView(frame: CGRectZero,style: style)
        self.tableView.separatorStyle = .SingleLine;
        self.tableView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight];
        self.tableView.showsVerticalScrollIndicator = true;
        self.tableView.keyboardDismissMode = .OnDrag;
        super.init();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = UIView();
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.frame = self.view.bounds;
        self.view.addSubview(self.tableView)
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return TMPJTableViewCell();
    }
}
