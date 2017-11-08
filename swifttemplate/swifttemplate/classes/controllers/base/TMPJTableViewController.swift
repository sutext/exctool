//
//  TMPJTableViewController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//
import Airmey

class TMPJTableViewController: TMPJBaseViewController{
    let tableView : TMPJTableView
    var tableInsets : AMConstraintInsets!
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
        self.tableView.tableFooterView = UIView()
        let left = self.tableView.adhere(left: nil)
        let right = self.tableView.adhere(right: nil)
        let top = self.tableView.topAnchor.equal(to: self.topLayoutGuide.bottomAnchor)
        let bottom = self.tableView.bottomAnchor.equal(to: self.bottomLayoutGuide.topAnchor)
        self.tableInsets = AMConstraintInsets(top:top,left:left,bottom:bottom,right:right)
    }
    func loadMore() {
        
    }
}
extension TMPJTableViewController:UITableViewDelegate,UITableViewDataSource
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
}
extension TMPJTableViewController:AMTableViewDelegate
{
    func tableView(_ tableView: AMTableView, willBeginRefreshWithStyle style: AMRefreshStyle, refreshControl: AMRefreshProtocol) {
        switch style {
        case .top:
            self.reloadData()
        case .bottom:
            self.loadMore()
        }
    }
}
