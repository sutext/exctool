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
        self.pickerView.frame = CGRect(x:0,y: 44,width: self.actionView.width,height: self.actionView.height - 44);
        self.pickerView.dataSource=self;
        self.pickerView.delegate=self;
        self.pickerView.backgroundColor = UIColor.white;
        self.actionView.addSubview(self.pickerView);
        self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0);
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
    func hide(_ completed:Bool){}
    func show(){}
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0;
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
