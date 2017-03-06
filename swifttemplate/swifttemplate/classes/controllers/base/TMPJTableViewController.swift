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
        self.init(style:.plain);
    }
    init(style:UITableViewStyle) {
        self.tableView=TMPJTableView(frame: CGRect.zero,style: style)
        self.tableView.separatorStyle = .singleLine;
        self.tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight];
        self.tableView.showsVerticalScrollIndicator = true;
        self.tableView.keyboardDismissMode = .onDrag;
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TMPJTableViewCell();
    }
}
