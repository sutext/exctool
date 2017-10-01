//
//  CTPickerController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//

import EasyTools


class TMPJPickerController: TMPJBaseViewController {
    var actionView:UIView = UIView();
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4);
        self.view.alpha = 0;
        self.actionView.frame = CGRect(x:0,y: self.view.height,width: self.view.width,height: 260)
        self.view.addSubview(self.actionView);
        self.actionView.backgroundColor = kTMPJSeparatorColor;
        let cancelButton = self.buttonWithTitle("取消");
        cancelButton.clickedAction = {[unowned self] bnt in
            self.hide(false);
        }
        let completed = self.buttonWithTitle("完成");
        completed.right = self.actionView.width;
        completed.clickedAction = {[unowned self] bnt in
            self.hide(true);
        }
        self.pickerDidLoad();
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.actionView.top = self.view.height - 260;
            self.view.alpha = 1;
        }
    }
    
    func buttonWithTitle(_ title:String) ->TMPJButton
    {
        let button = TMPJButton(frame:CGRect(x: 0, y: 0, width: 44, height: 44));
        button.setTitleColor(kTMPJFirstTextColor, for: .normal);
        button.setTitle(title, for: .normal);
        button.titleLabel?.font = kTMPJStandardFont;
        self.actionView.addSubview(button);
        return button;
    }
    private func hide(_ completed:Bool){
        UIView.animate(withDuration: 0.5, animations: {
            self.actionView.top = self.view.height;
            self.view.alpha = 0;
        }) { (finish) in
            self.pickerDidHide();
            ETGlobalContainer.single.dismissController();
        }
    }
    func show(){
        ETGlobalContainer.single.present(self);
    }
    
    //MARK: overwrite point
    func pickerDidLoad()
    {
        
    }
    func pickerDidHide()
    {
        
    }
}
