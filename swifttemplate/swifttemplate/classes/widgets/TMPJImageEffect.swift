//
//  TMPJImageEffect.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit

class TMPJImageEffect: UIView {
    let imageView = TMPJImageView()
    private var effect:UIVisualEffectView?
    private var effectLayer:CAGradientLayer?
    deinit {
        if self.effectLayer != nil {
            self.imageView.removeObserver(self, forKeyPath: "bounds")
        }
    }
    init(){
        super.init(frame: .zero)
        self.addSubview(self.imageView)
        self.imageView.contentMode = .scaleToFill
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.adhere(insets: nil)
    }
    convenience init(style:UIBlurEffectStyle) {
        self.init()
        self.setBlurEffect(style)
    }
    func setBlurEffect(_ style:UIBlurEffectStyle){
        self.setVisualEffect(UIBlurEffect(style: style))
    }
    func setVisualEffect(_ effect:UIVisualEffect){
        if self.effect == nil {
            self.effect = UIVisualEffectView(effect: effect)
            self.addSubview(self.effect!)
            self.effect!.translatesAutoresizingMaskIntoConstraints = false
            self.effect!.adhere(insets: nil)
        }else{
            self.effect?.effect = effect
        }
    }
    func setGradientEffect(for block:((CAGradientLayer)->Void)){
        if self.effectLayer == nil {
            let layer = CAGradientLayer()
            self.effectLayer = layer
            self.imageView.layer.addSublayer(layer)
            self.imageView.addObserver(self, forKeyPath: "bounds", options: [.new], context: nil)
        }
        block(self.effectLayer!)
    }
    func setKaraokEffect(){
        self.setGradientEffect { (layer) in
            layer.colors = [
                UIColor(0x000000,alpha:1).cgColor,
                UIColor(0x000000,alpha:0.5).cgColor,
                UIColor(0x000000,alpha:0).cgColor,
                UIColor(0x000000,alpha:0).cgColor,
                UIColor(0x000000,alpha:0.5).cgColor,
                UIColor(0x000000,alpha:1).cgColor,
            ]
            layer.locations = [0,0.1,0.15,0.85,0.9,1]
            layer.startPoint = CGPoint(x:0,y:0)
            layer.endPoint = CGPoint(x:0,y:1)
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DispatchQueue.main.async {
            if keyPath == "bounds"{
                self.effectLayer?.frame = self.imageView.bounds
            }
        }
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

