//
//  TMPJImageLabel.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//
import Airmey

final class TMPJImageLabel: TMPJView {
    enum Layout {
        case left
        case right
        case top
        case bottom
    }
    private(set) var layout:Layout
    private let stackView = TMPJStackView()
    var stackInsets:AMConstraintInsets?
    let imageView = TMPJImageView()
    let textLabel = TMPJLabel()
    var text:String?
    {
        get{
            return self.textLabel.text
        }
        set {
            self.textLabel.text = newValue
        }
    }
    var count:Int64?{
        didSet{
            self.textLabel.text = count?.description
        }
    }
    var image:UIImage?
    {
        get{
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    var spaceing:CGFloat{
        get{
            return self.stackView.spacing
        }
        set{
            self.stackView.spacing = newValue
        }
    }
    init(_ layout:Layout = .left,image:UIImage? = nil , text:String? = nil) {
        self.layout = layout
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        
        self.imageView.contentMode = .scaleToFill
        self.imageView.image = image
        self.textLabel.text = text
        self.textLabel.font = .size14
        self.textLabel.textColor = .mainText
        
        self.stackView.spacing = 2.0
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .center
        
        self.stackInsets = self.stackView.adhere(insets: nil)
        switch layout {
        case .left:
            self.stackView.axis = .horizontal
            self.stackView.addArrangedSubview(self.imageView)
            self.stackView.addArrangedSubview(self.textLabel)
            
        case .right:
            self.stackView.axis = .horizontal
            self.stackView.addArrangedSubview(self.textLabel)
            self.stackView.addArrangedSubview(self.imageView)
        case .top:
            self.stackView.axis = .vertical
            self.stackView.addArrangedSubview(self.imageView)
            self.stackView.addArrangedSubview(self.textLabel)
        case .bottom:
            self.stackView.axis = .vertical
            self.stackView.addArrangedSubview(self.textLabel)
            self.stackView.addArrangedSubview(self.imageView)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
