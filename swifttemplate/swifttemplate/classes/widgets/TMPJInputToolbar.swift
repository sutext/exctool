//
//  TMPJInputToolbar.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//
import Airmey

///this is an abstract class
///just implement bar position appearence
///user must subclass this and implement his apperence

class TMPJInputToolbar:UIView{
    
    ///subclass must node that
    ///the textView didn't been add to subviews
    ///this class didn't manage the textView's appearence
    ///this class just manage the data property of the textView
    
    let textView:TMPJTextView
    let keybord:AMKeyboardController
    let standardHeight:CGFloat = 50
    fileprivate var bottomConstraint:NSLayoutConstraint!
    fileprivate var heightConstraint:NSLayoutConstraint!
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    init(_ textView:TMPJTextView?){
        let textv = textView ?? TMPJTextView()
        self.keybord = AMKeyboardController(textv)
        self.keybord.register(AMEmojKeybord.self, for: .emoj)
        self.textView = textv
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightConstraint = self.heightAnchor.equal(to: 50)
        self.layer.shadowOpacity = 0.15
        self.layer.shadowColor = UIColor(0x000000,alpha:0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.addObserve()
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
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let _ = self.superview{
            self.adhere(left: nil)
            self.adhere(right: nil)
            self.bottomConstraint = self.adhere(bottom: nil)
        }
    }
    fileprivate func addObserve() {
        NotificationCenter.default.addObserver(self, selector: #selector(TMPJInputToolbar.keyboarWillShow(sender:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TMPJInputToolbar.keyboarWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboarWillShow(sender:Notification?) {
        let height = (sender?.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
        self.setup(bottom: -height)
    }
    @objc func keyboarWillHide(sender:Notification?) {
        self.setup(bottom: 0)
    }
    func setup(bottom:CGFloat){
        self.bottomConstraint.constant = bottom
        UIView.animate(withDuration: 0.25) {
            self.superview?.layoutIfNeeded();
        }
    }
    func setup(height:CGFloat){
        self.heightConstraint.constant = height
        UIView.animate(withDuration: 0.25) {
            self.superview?.layoutIfNeeded();
        }
    }
}
