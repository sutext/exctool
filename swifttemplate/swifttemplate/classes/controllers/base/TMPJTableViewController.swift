//
//  TMPJTableViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//
import Airmey

class TMPJTableViewController: TMPJBaseViewController{
    let tableView : TMPJTableView
    private(set) var tableInsets:AMConstraintInsets!
    override convenience init() {
        self.init(style:.plain);
    }
    init(style:UITableViewStyle) {
        self.tableView=TMPJTableView(frame: CGRect.zero,style: style)
        super.init();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.addSubview(self.tableView)
        self.tableInsets = self.tableView.adhere(insets: nil)
        self.tableView.contentInset = UIEdgeInsets(top: self.topbarInset, left: 0, bottom: self.bottomInset, right: 0)
    }
    
    func loadMore() {
        
    }
}
extension TMPJTableViewController:AMTableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TMPJTableViewCell();
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    func tableView(_ tableView: AMTableView, willRefreshUsing control: AMRefreshControl, with style: AMRefreshStyle) {
        switch style {
        case .top:
            self.reloadData()
        case .bottom:
            self.loadMore()
        }
    }
}
