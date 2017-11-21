//
//  TMPJTextPickerController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2017年 icegent. All rights reserved.
//

import Airmey

class TMPJTextPickerController<ActionItem:AMNameConvertible>:
    TMPJPickerController,
    UIPickerViewDelegate,
    UIPickerViewDataSource
{
    var finishBlock:((TMPJTextPickerController,ActionItem,Int)->Void)?
    private let pickerView = UIPickerView()
    private var items:[ActionItem]
    private var currentIndex:Int = 0
    init(_ items:[ActionItem],current:ActionItem?) {
        if let curr = current {
            if let idx = items.index(where: { (item) -> Bool in
                return item.name == curr.name
            }){
                self.currentIndex = idx
            }else{
                self.currentIndex = items.count/2
            }
        }
        self.items = items
        super.init()
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        self.pickerView.adhere(insets: nil)
        self.pickerView.selectRow(self.currentIndex, inComponent: 0, animated: true)
    }
    override func finishAction(sender: UIButton) {
        self.dismiss(animated: true) {
            self.finishBlock?(self,self.items[self.currentIndex],self.currentIndex)
        }
    }
    func createLabel(text:String?) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(0x333333)
        label.textAlignment = .center
        label.text = text
        return label
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let item = self.items[row]
        guard let label = view as? UILabel else {
            return self.createLabel(text: item.name)
        }
        label.text = item.name
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentIndex = row
    }
}
