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
    private var actionView:UIView = UIView();
    private var completed:((sender:CTActionController,item:ActionItem!,index:Int!)->Void)!;
    private var items:[ActionItem]!;
    private var actions:[TMPJButton] = [];
    init(items:[ActionItem],completed:((sender:CTActionController,item:ActionItem!,index:Int!)->Void)) {
        super.init(style:.Grouped);
        self.completed = completed;
        self.items = items;
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4);
        self.view.alpha = 0;
        
        let blurView = TMPJView(frame:self.view.bounds)
        blurView.backgroundColor = UIColor.clearColor();
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
        self.actionView.frame = CGRectMake(0, self.view.height, self.view.width, totalHeight)
        self.view.addSubview(self.actionView);
        self.actionView.backgroundColor = kTMPJSeparatorColor;
        
        self.tableView.frame = CGRectMake(0, 0, self.actionView.width, tableHeight);
        self.tableView.backgroundColor = UIColor.clearColor();
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.scrollEnabled = (self.items.count > self.maxLineCont);
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
        UIView.animateWithDuration(0.3) { () -> Void in
            self.actionView.top = self.view.height - totalHeight;
            self.view.alpha = 1;
        }
    }
    
    func addAction(title:String,color:UIColor = UIColor.blackColor(),action:(()->Void)? = nil)
    {
        let actionButton = TMPJButton.actionButton(title, titleColor: color);
        actionButton.clickedAction = {[unowned self] bnt in
            self.hide(action: action);
        };
        self.actions.append(actionButton);
    }
    
    func show()
    {
        ETGlobalContainer.singleContainer().present(self);
    }
    func hide(index:Int? = nil,action:(()->Void)? = nil)
    {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.actionView.top = self.view.height;
            self.view.alpha = 0;
            }, completion: { (comp) -> Void in
                if let idx = index
                {
                    self.completed(sender: self, item: self.items[idx],index: idx);
                }
                if let  block = action
                {
                    block();
                }
                ETGlobalContainer.singleContainer().dismissController();
        })
    }
    //MARK:  --UITableView methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("actionCell") as? TMPJTableViewCell;
        if cell == nil
        {
            cell = TMPJTableViewCell(style: .Default, reuseIdentifier: "actionCell");
            cell?.accessoryType = .None;
            cell?.textLabel?.textAlignment = .Center;
        }
        cell!.textLabel?.text = self.items[indexPath.row].name;
        return cell!;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        self.hide(indexPath.row);
    }
}
