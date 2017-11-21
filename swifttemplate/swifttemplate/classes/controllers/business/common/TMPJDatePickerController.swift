//
//  TMPJDatePickerController.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey

final class TMPJDatePickerController: TMPJPickerController {
    private let datePicker = UIDatePicker()
    private var finishBlock:((_ date:Date)->Void)?
    convenience init(completion:((_ date:Date)->Void)?) {
        self.init();
        self.finishBlock = completion;
    }
    var date:Date{
        get{
            return self.datePicker.date
        }
        set{
            self.datePicker.date = newValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.datePickerMode = .date
        self.contentView.addSubview(self.datePicker)
        self.datePicker.adhere(insets: nil)
    }
    override func finishAction(sender: UIButton) {
        self.dismiss(animated: true) {
            self.finishBlock?(self.date)
        }
    }
}
