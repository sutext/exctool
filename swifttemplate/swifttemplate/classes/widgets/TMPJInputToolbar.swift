//
//  TMPJInputToolbar.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2017年 icegent. All rights reserved.
//
import Airmey

///this is an abstract class
///just implement bar position appearence
///user must subclass this and implement his apperence

class TMPJInputToolbar:AMToolBar{
    
    ///subclass must node that
    ///the textView didn't been add to subviews
    ///this class didn't manage the textView's appearence
    ///this class just manage the data property of the textView
    
    let textView:TMPJTextView
    let keybord:AMKeyboardController
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    init(_ textView:TMPJTextView?){
        let textv = textView ?? TMPJTextView()
        self.keybord = AMKeyboardController(textv)
        self.keybord.register(AMEmojKeyboard.self, for: .emoj)
        self.textView = textv
        super.init(style:.normal)
        NotificationCenter.default.addObserver(self, selector: #selector(TMPJInputToolbar.keyboarWillShow(sender:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TMPJInputToolbar.keyboarWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
        if textView == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(TMPJInputToolbar.textDidChange(sender:)), name: .UITextViewTextDidChange, object: self.textView)
        }
    }
    func dismissKeyboard(){
        self.keybord.dismissKeyboard()
    }
    func presentKeyboard(){
        self.keybord.presentKeyboard()
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
extension TMPJInputToolbar
{
    @objc func textDidChange(sender:Notification?) {
        let size = self.textView.sizeThatFits(CGSize(width: self.textView.frame.width, height: 100000))
        switch (size.height)
        {
        case ...35:
            self.setup(height: TMPJInputToolbar.contentHeight)
        case 35...82:
            self.setup(height: size.height+20)
        case 82...:
            self.setup(height: 102)
        default:
            break;
        }
    }
    @objc func keyboarWillShow(sender:Notification?) {
        let height = (sender?.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
        self.setup(bottom: -height + .footerHeight)
    }
    @objc func keyboarWillHide(sender:Notification?) {
        self.setup(bottom: 0)
    }
}
