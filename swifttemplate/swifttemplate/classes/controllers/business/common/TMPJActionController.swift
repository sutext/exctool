//
//  CTActionController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//

import EasyTools

class CTActionController<ActionItem:TMPJNameConvertibale>: TMPJTableViewController {
    var maxLineCont = 4;
    fileprivate var actionView:UIView = UIView();
    fileprivate var completed:((_ sender:CTActionController,_ item:ActionItem?,_ index:Int?)->Void);
    fileprivate var items:[ActionItem] = [];
    fileprivate var actions:[TMPJButton] = [];
    init(items:[ActionItem],completed:@escaping ((_ sender:CTActionController,_ item:ActionItem?,_ index:Int?)->Void)) {
        self.completed = completed;
        super.init(style:.grouped);
        self.items = items;
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4);
        self.view.alpha = 0;
        let blurView = TMPJView(frame:self.view.bounds)
        blurView.backgroundColor = UIColor.clear;
        blurView.tapAction = {[unowned self] blv in
            self.hide();
        }
        self.view.addSubview(blurView);
        let showCount = (self.items.count > self.maxLineCont ? self.maxLineCont : self.items.count)
        let tableHeight = CGFloat(showCount * 50);
        let actionHeight = CGFloat( self.actions.count * 51);
        var totalHeight  = tableHeight + actionHeight + 3;
        if showCount == 0
        {
            totalHeight = actionHeight;
        }
        self.actionView.frame = CGRect(x:0,y: self.view.height,width: self.view.width,height: totalHeight)
        self.view.addSubview(self.actionView);
        self.actionView.backgroundColor = kTMPJSeparatorColor;
        
        self.tableView.frame = CGRect(x:0,y: 0,width: self.actionView.width,height: tableHeight);
        self.tableView.backgroundColor = UIColor.clear;
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.isScrollEnabled = (self.items.count > self.maxLineCont);
        self.actionView.addSubview(self.tableView);
        
        var top = tableHeight + 4;
        if showCount == 0
        {
            top = 0;
        }
        for action in actions
        {
            action.top = top;
            top = action.bottom+1;
            self.actionView.addSubview(action);
        }
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.actionView.top = self.view.height - totalHeight;
            self.view.alpha = 1;
        }
    }
    
    func addAction(_ title:String,color:UIColor = UIColor.black,action:(()->Void)? = nil)
    {
        let actionButton = TMPJButton.actionButton(title, titleColor: color);
        actionButton.clickedAction = {[unowned self] bnt in
            self.hide(action: action);
        };
        self.actions.append(actionButton);
    }
    
    func show()
    {
        ETGlobalContainer.single.present(self);
    }
    func hide(_ index:Int? = nil,action:(()->Void)? = nil)
    {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.actionView.top = self.view.height;
            self.view.alpha = 0;
            }, completion: { (comp) -> Void in
                if let idx = index
                {
                    self.completed(self, self.items[idx],idx);
                }
                if let  block = action
                {
                    block();
                }
                ETGlobalContainer.single.dismissController();
        })
    }
    //MARK:  --UITableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "actionCell") as? TMPJTableViewCell;
        if cell == nil
        {
            cell = TMPJTableViewCell(style: .default, reuseIdentifier: "actionCell");
            cell?.accessoryType = .none;
            cell?.textLabel?.textAlignment = .center;
        }
        cell!.textLabel?.text = self.items[indexPath.row].name;
        return cell!;
    }
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true);
        self.hide(indexPath.row);
    }
}
