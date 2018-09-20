//
//  TMPJTextEditerController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJTextEditerController: TMPJTableViewController{
    fileprivate var textField = TMPJTextField()
    fileprivate var placeholder:String?;
    fileprivate var completedBlock:((String?) -> Void)!
    var keybordType:UIKeyboardType = .default;
    var limitTextLenth:Int = 0;
    var outlenthMessage:String?
    var submitTitle:String = "确定"
    convenience init(placeholder:String?,completed:@escaping ((_ text: String?) -> Void))
    {
        self.init(style:.grouped);
        self.placeholder = placeholder;
        self.completedBlock = completed;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRightbar(title: "完成")
        self.textField.placeholder = self.placeholder;
        self.textField.keyboardType = self.keybordType;
        self.textField.clearButtonMode = .always;
        
        if (self.outlenthMessage != nil)
        {
            self.textField.delegate = self;
        }
    }
    override func rightItemAction(_ sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
        self.completedBlock(self.textField.text);
    }
}
extension TMPJTextEditerController{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMPJTableViewCell(style: .default, reuseIdentifier: nil);
        cell.contentView.addSubview(self.textField)
        self.textField.adhere(insets: nil)
        return cell;
    }
}
extension TMPJTextEditerController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text!.length >= self.limitTextLenth && string.length>0)
        {
            pop.alert(self.outlenthMessage)
            return false;
        }
        return true;
    }
}
