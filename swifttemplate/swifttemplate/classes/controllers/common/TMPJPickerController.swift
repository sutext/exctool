//
//  CTPickerController.swift
//  CoreTeahouse
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import Airmey

class TMPJPickerController: UIViewController {
    public let contentView:UIView = UIView()
    private let cancelButton:UIButton = UIButton()
    private let finishBUtton:UIButton = UIButton()
    private let effectView = AMEffectView()
    private let animator:AMPresentFrameAssistor = AMPresentFrameAssistor(264 + .footerHeight)
    init() {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = self.animator
        self.modalPresentationStyle = .custom
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.transitioningDelegate = self.animator
        self.modalPresentationStyle = .custom
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.effectView)
        self.setup(for: self.cancelButton,with:"取消")
        self.setup(for: self.finishBUtton,with: "完成")
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.contentView)
        self.effectView.adhere(insets: nil)
        self.cancelButton.adhere(top: 10)
        self.cancelButton.adhere(left: 10)
        self.finishBUtton.adhere(top: 10)
        self.finishBUtton.adhere(right: 10)
        self.contentView.adhere(top: 44)
        self.contentView.adhere(left: nil)
        self.contentView.adhere(right: nil)
        self.contentView.heightAnchor.equal(to: 220)
        self.cancelButton.addTarget(self, action: #selector(TMPJPickerController.cancelAction(sender:)), for: .touchUpInside)
        self.finishBUtton.addTarget(self, action: #selector(TMPJPickerController.finishAction(sender:)), for: .touchUpInside)
    }
    private func setup(for button:UIButton,with title:String)
    {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.theme, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(button)
    }
}
///overwrite  points
extension TMPJPickerController{
    @objc dynamic func cancelAction(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @objc dynamic func finishAction(sender:UIButton){
        
    }
}
