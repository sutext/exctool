//
//  CTPickerController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import Airmey


class TMPJPickerController: TMPJBaseViewController {
    let contentView:UIView = UIView()
    let cancelButton:TMPJButton = TMPJButton()
    let completeButton:TMPJButton = TMPJButton()
    let animator:AMPresentFrameAssistor = AMPresentFrameAssistor(264)
    override init() {
        super.init()
        self.transitioningDelegate = self.animator
        self.modalPresentationStyle = .custom
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup(for: self.cancelButton,with:"取消")
        self.setup(for: self.completeButton,with: "完成")
        self.view.addSubview(self.contentView)
        self.view.backgroundColor = .white
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.adhere(top: 10)
        self.cancelButton.adhere(left: 10)
        self.completeButton.adhere(top: 10)
        self.completeButton.adhere(right: 10)
        self.contentView.adhere(top: 44)
        self.contentView.adhere(left: nil)
        self.contentView.adhere(right: nil)
        self.contentView.heightAnchor.equal(to: 240)
        
        self.cancelButton.clickedAction = {[weak self] sender in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    func setup(for button:TMPJButton,with title:String)
    {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.theme, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .size14
        self.view.addSubview(button)
    }
}
