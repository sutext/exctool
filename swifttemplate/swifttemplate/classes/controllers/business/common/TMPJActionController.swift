//
//  CTActionController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import Airmey
class TMPJActionController<ActionItem:AMNameConvertible>: TMPJTableViewController {
    private var completed:((_ sender:TMPJActionController,_ item:ActionItem?,_ index:Int?)->Void);
    private var items:[ActionItem] = [];
    private var actions:[TMPJButton] = [];
    private var animator:AMPresentFrameAssistor!
    private let cancelButton = TMPJButton.cover(title: "取消", size: CGSize(width:.screenWidth,height:50),titleColor:.black,titleFont:.size17)
    init(items:[ActionItem],completed:@escaping ((_ sender:TMPJActionController,_ item:ActionItem?,_ index:Int?)->Void)) {
        self.completed = completed
        let count = (items.count + 1).clamp(in: 1...6)
        super.init(style:.plain)
        self.tableView.isScrollEnabled = (items.count+1 > 6)
        self.items = items
        self.animator = AMPresentFrameAssistor(CGFloat(count*50)+2)
        self.transitioningDelegate = self.animator
        self.modalPresentationStyle = .custom
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.delaysContentTouches = false
        self.tableView.rowHeight = 50
        self.view.addSubview(self.cancelButton)
        self.cancelButton.adhere(bottom: nil)
        self.cancelButton.align(centerX: nil)
        self.cancelButton.clickedAction = {[weak self]sender in
            self?.hide()
        }
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 52, right: 0)
    }
    private func hide(_ index:Int? = nil)
    {
        self.dismiss(animated: true) {
            if let idx = index
            {
                self.completed(self, self.items[idx],idx);
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "actionCell") as? TMPJTableViewCell;
        if cell == nil
        {
            cell = TMPJTableViewCell(style: .default, reuseIdentifier: "actionCell");
            cell?.accessoryType = .none;
            cell?.textLabel?.textAlignment = .center;
            cell?.separatorInset = UIEdgeInsets.zero
        }
        cell!.textLabel?.text = self.items[indexPath.row].name;
        return cell!;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.hide(indexPath.row)
    }
}
