//
//  TMPJExtensions.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit
import Airmey

extension UINavigationBar
{
    enum BarStyle {
        case theme
        case clear
        static let `default`:BarStyle = .theme
    }
    func setBarColor(_ color:UIColor) {
        let image = UIImage.single(color: color, size: CGSize(width: 1, height: 1))
        self.setBackgroundImage(image, for: .default);
    }
    func setShadowColor(_ color:UIColor) {
        self.shadowImage = UIImage.single(color: color, size: CGSize(width: 1, height: 1));
    }
    func setTitleColor(_ color:UIColor) {
        self.titleTextAttributes=[.foregroundColor:color];
    }
    func setBarStyle(_ style:BarStyle) {
        switch style {
        case .theme:
            self.setShadowColor(.theme)
            self.setBarColor(.theme)
            self.setTitleColor(.white)
            self.tintColor = .white
        case .clear:
            self.setShadowColor(.clear)
            self.setBarColor(.clear)
            self.setTitleColor(.white)
            self.tintColor = .white
        }
    }
}
extension TimeInterval
{
    var hhmmss:String{
        let inttime = Int(self)
        let sec = inttime%60
        var min = inttime/60
        let hour = min/60
        min = min%60
        return String(format: "%02d:%02d:%02d", hour,min,sec)
    }
    var mmss:String{
        let inttime = Int(self)
        let min = inttime/60
        let sec = inttime%60
        return String(format: "%02d:%02d", min,sec)
    }
    func string(for style:Date.Style) -> String {
        return Date.formater(for: style).string(from: Date(timeIntervalSince1970: self))
    }
}
extension Date
{
    enum Style :String{
        case normal = "MM-dd HH:mm"
        case date = "yyyy-MM-dd"
        case month = "MM月 dd日"
        case hour   = "HH:mm"
        case minute = "mm:ss"
        case full = "yyyy-MM-dd HH:mm:ss"
    }
    private static let storedFormat = NSMutableDictionary()
    fileprivate static func formater(for style:Style) -> DateFormatter {
        if let formater = Date.storedFormat[style] as? DateFormatter
        {
            return formater
        }
        let formater = DateFormatter()
        formater.dateFormat = style.rawValue
        Date.storedFormat[style] = formater
        return formater
    }
    func string(for style:Style) -> String {
        return Date.formater(for: style).string(from: self)
    }
}
extension CAAnimation
{
    static let rotation:CAAnimation = {
        let ani = CABasicAnimation(keyPath: "transform.rotation.z")
        ani.byValue = 0.05
        ani.duration = 0.1
        ani.autoreverses = false
        ani.isRemovedOnCompletion = false
        ani.fillMode = kCAFillModeForwards
        ani.isCumulative = true
        ani.repeatCount = Float(Int.max)
        return ani
    }()
}
extension CALayer
{
    enum AnimationType:String {
        case rotation = "swifttemplate.rotation"
        var animation:CAAnimation{
            switch self {
            case .rotation:
                return .rotation
            }
        }
    }
    func resume(_ type:AnimationType) {
        guard let _ = self.animation(forKey: type.rawValue) else{
            self.add(type.animation, forKey: type.rawValue)
            return
        }
        guard self.speed == 0.0 else {
            return
        }
        let pausedTime = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        let timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
    func pause(_ type:AnimationType)  {
        guard let _ = self.animation(forKey: type.rawValue) else{
            return
        }
        guard self.speed == 1.0 else {
            return
        }
        let pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
        self.speed = 0.0
        self.timeOffset = pausedTime
    }
    func remove(_ type:AnimationType) {
        if let _ = self.animation(forKey: type.rawValue) {
            self.removeAnimation(forKey: type.rawValue)
        }
    }
}
extension String
{
    func date(for style:Date.Style) -> Date? {
        return Date.formater(for: style).date(from: self)
    }
}
extension Int64{
    var formated:String{
        switch self {
        case Int64.min..<0:
            return "0"
        case  0..<1000:
            return "\(self)"
        case 1000..<100000:
            return "\(self/1000)k"
        case 100000..<1000000:
            return "\(self/10000)w"
        case 1000000..<Int64.max :
            return "100w+"
        default:
            return ""
        }
    }
}
extension String
{
    static var cachePath:String{
        if let str  = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first {
            return str
        }
        return NSTemporaryDirectory()
    }
    static var documentPath:String{
        if let str  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            return str
        }
        return NSTemporaryDirectory()
    }
    static var temporaryPath:String{
        return NSTemporaryDirectory()
    }
}
extension DispatchQueue
{
    func after(_ delay:TimeInterval,block:@escaping (()->Void)) {
        self.asyncAfter(deadline: DispatchTime.now() + delay, execute: block);
    }
}
extension UIApplication{
    private var lastPresentedController:UIViewController?{
        var next:UIViewController? = self.keyWindow?.rootViewController
        while next?.presentedViewController != nil {
            next = next?.presentedViewController
        }
        return next
    }
    var appid:String{
        return "1318071927"
    }
    var storeURL:String{
        return "https://itunes.apple.com/cn/app/id\(appid)?mt=8"
    }
    func present(_ viewController:UIViewController,animated:Bool,completion:(()->Void)?){
        self.lastPresentedController?.present(viewController, animated: animated, completion: completion)
    }
    func jumptoAppstore(){
        if let url = URL(string: self.storeURL){
            self.openURL(url)
        }
    }
    func jumptoLogin(){
    }    
}
