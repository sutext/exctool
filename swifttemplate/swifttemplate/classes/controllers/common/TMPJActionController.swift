//
//  CTActionController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey
class TMPJActionController<ActionItem:AMNameConvertible>:UIViewController,
    UITableViewDataSource,
UITableViewDelegate{
    var finishBlock:((TMPJActionController,ActionItem,Int)->Void)?
    private let effectView = AMEffectView()
    private var items:[ActionItem]
    private let animator:AMPresentFrameAssistor
    private let cancelBar = TMPJCancelBar()
    private let tableView = UITableView()
    private let rowHeight:CGFloat = 50
    init(_ items:[ActionItem]) {
        let count = items.count.clamp(in: 1...5)
        self.items = items
        self.animator = AMPresentFrameAssistor(CGFloat(count)*self.rowHeight + .tabbarHeight)
        super.init(nibName: nil, bundle: nil)
        self.tableView.isScrollEnabled = (items.count > 5)
        self.automaticallyAdjustsScrollViewInsets = false
        self.transitioningDelegate = self.animator
        self.modalPresentationStyle = .custom
    }
    ///dos't implement NSCoding protocol
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.effectView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.cancelBar)
        self.effectView.adhere(insets: nil)
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
        self.tableView.delaysContentTouches = false
        self.tableView.separatorStyle = .singleLine
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.rowHeight = self.rowHeight
        self.tableView.backgroundColor = .clear
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.adhere(left: nil)
        self.tableView.adhere(top: nil)
        self.tableView.adhere(right: nil)
        self.tableView.heightAnchor.equal(to: CGFloat(self.items.count.clamp(in: 1...5)*50))
        self.cancelBar.control.addTarget(self, action: #selector(TMPJActionController.cancelAction(sender:)), for: .touchUpInside)
    }
    @objc dynamic func cancelAction(sender:UIControl){
        self.hide()
    }
    private func hide(_ index:Int? = nil)
    {
        self.dismiss(animated: true) {
            if let idx = index
            {
                self.finishBlock?(self, self.items[idx],idx);
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "actionCell")
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "actionCell");
            cell?.accessoryType = .none;
            cell?.textLabel?.textAlignment = .center;
            cell?.separatorInset = UIEdgeInsets.zero
            cell?.backgroundColor = .clear
        }
        cell!.textLabel?.text = self.items[indexPath.row].name;
        return cell!;
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.hide(indexPath.row)
    }
}
class TMPJCancelBar:AMToolBar{
    let label = UILabel()
    let control = UIControl()
    init(){
        super.init(style:.normal)
        self.shadowLine.isHidden = true
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.control.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.label)
        self.addSubview(self.control)
        self.label.text = "取消"
        self.label.font = .size18
        self.label.textColor = .theme
        self.label.align(centerX: nil)
        self.label.align(centerY: nil)
        self.control.adhere(insets: nil)
        self.control.addTarget(self, action: #selector(TMPJCancelBar.touchDown), for: .touchDown)
        self.control.addTarget(self, action: #selector(TMPJCancelBar.touchUp), for: .touchUpInside)
        self.control.addTarget(self, action: #selector(TMPJCancelBar.touchUp), for: .touchUpOutside)
    }
    @objc func touchDown(){
        self.backgroundColor = .lightGray
    }
    @objc func touchUp(){
        self.backgroundColor = .clear
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
