//
//  TMPJCollectionViewCell.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setupUI();
    }
    lazy var imageView:TMPJImageView = {
        var image = TMPJImageView();
        image.clipsToBounds = true;
        self.contentView.addSubview(image);
        return image;
    }()
    lazy var textLabel:TMPJLabel = {
        var label = TMPJLabel();
        label.font = .size14
        label.textColor = .mainText
        self.contentView.addSubview(label);
        return label;
    }()
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc dynamic func setupUI(){
        
    }
}
class TMPJCollectionViewSectionHeader: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setupUI();
    }
    lazy var imageView:TMPJImageView = {
        var image = TMPJImageView();
        self.addSubview(image);
        return image;
    }()
    lazy var textLabel:TMPJLabel = {
        var label = TMPJLabel();
        self.addSubview(label);
        return label;
    }()
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        
    }
}

class TMPJCollectionViewArrowHeader: TMPJCollectionViewSectionHeader {
    private let rightArrow = TMPJImageView(w:7,h:12)
    private let contentView = TMPJView()
    override func setupUI() {
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.rightArrow)
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.textLabel)
        
        self.contentView.backgroundColor = .white
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.constraint(width: 3, height: 17)
        self.imageView.backgroundColor = .theme
        self.textLabel.font = .size14;
        self.rightArrow.image = UIImage(named:"icon_right_arrow_gray")
        self.contentView.leftAnchor.equal(to: self.leftAnchor)
        self.contentView.rightAnchor.equal(to: self.rightAnchor)
        self.contentView.topAnchor.equal(to: self.topAnchor)
        self.contentView.bottomAnchor.equal(to: self.bottomAnchor)
        
        self.imageView.leftAnchor.equal(to: self.contentView.leftAnchor,offset:8);
        self.textLabel.leftAnchor.equal(to: self.imageView.rightAnchor,offset:10)
        self.rightArrow.rightAnchor.equal(to: self.contentView.rightAnchor,offset:-8)
        
        self.imageView.centerYAnchor.equal(to: self.contentView.centerYAnchor)
        self.textLabel.centerYAnchor.equal(to: self.contentView.centerYAnchor)
        self.rightArrow.centerYAnchor.equal(to: self.contentView.centerYAnchor)
    }
    func setAction(_ action : ((TMPJCollectionViewArrowHeader)->Void)?)  {
        if let block = action {
            self.contentView.singleAction = {[weak self] sender in
                if let wself = self
                {
                    block(wself)
                }
            }
            return
        }
        self.contentView.singleAction = nil
    }
}
class  TMPJEqualSpacingLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else{
            return nil
        }
        guard let leftPadding = attributes.first?.frame.origin.x else {
            return nil
        }
        let count = attributes.count
        for i in 0..<count {
            let attri = attributes[i]
            if attri.frame.origin.x != leftPadding && attri.representedElementKind == nil{
                let preAttri = attributes[i - 1]
                attri.frame.origin.x = preAttri.frame.maxX + self.minimumInteritemSpacing
            }
        }
        return attributes
    }
}
