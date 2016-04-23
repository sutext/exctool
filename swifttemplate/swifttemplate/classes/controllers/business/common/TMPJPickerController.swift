//
//  CTPickerController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 mding. All rights reserved.
//

import EasyTools


class TMPJPickerController: TMPJBaseViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var actionView:UIView = UIView();
    var pickerView:UIPickerView = UIPickerView();
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4);
        self.view.alpha = 0;
        self.actionView.frame = CGRectMake(0, self.view.height, self.view.width, 260)
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
        self.pickerView.frame = CGRectMake(0, 44, self.actionView.width, self.actionView.height - 44);
        self.pickerView.dataSource=self;
        self.pickerView.delegate=self;
        self.pickerView.backgroundColor = UIColor.whiteColor();
        self.actionView.addSubview(self.pickerView);
        self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0);
        UIView.animateWithDuration(0.5) { () -> Void in
            self.actionView.top = self.view.height - 260;
            self.view.alpha = 1;
        }
    }
    func buttonWithTitle(title:String) ->TMPJButton
    {
        let button = TMPJButton(frame:CGRectMake(0, 0, 44, 44));
        button.setTitleColor(kTMPJFirstTextColor, forState: .Normal);
        button.setTitle(title, forState: .Normal);
        button.titleLabel?.font = kTMPJStandardFont;
        self.actionView.addSubview(button);
        return button;
    }
    func hide(completed:Bool){}
    func show(){}
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 0;
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0;
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
