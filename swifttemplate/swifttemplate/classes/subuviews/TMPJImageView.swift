//
//  TMPJImageView.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

class TMPJImageView: AMImageView {
    enum Style :String{
        case none = ""
        case avator = "?x-oss-process=style/icegent_avatar_mini"
        case photo = "?x-oss-process=style/icegent_photo_mini"
    }
    private var wconst:NSLayoutConstraint?
    private var hconst:NSLayoutConstraint?
    init() {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    convenience init(w:CGFloat,h:CGFloat) {
        self.init()
        
        self.constraint(width: w, height: h)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    func constraint(width:CGFloat,height:CGFloat){
        if let wc = self.wconst {
            wc.constant = width;
        }
        else
        {
            self.wconst = self.widthAnchor.equal(to: width)
        }
        if let hc = self.hconst {
            hc.constant = height;
        }
        else
        {
            self.hconst = self.heightAnchor.equal(to: height)
        }
    }
    convenience required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func imageURL(for osskey:String,with style:Style = .none) -> String
    {
        return "http://image.karaok.icegent.com/\(osskey)\(style.rawValue)";
    }
    func set(imageURL: String?, style:Style = .none,scale:CGFloat = 3,placeholder: UIImage? = nil, completion: ((UIImage?, Error?, TMPJImageView) -> Void)? = nil) {
        if let URLString = imageURL
        {
            if URLString.hasPrefix("http") {
                self.setImage(with: URLString, placeholder: placeholder, finish: { (img, error) in
                    completion?(img,error,self);
                })
            }
            else
            {
                let url = TMPJImageView.imageURL(for: URLString, with: style)
                self.setImage(with: url,scale:scale, placeholder: placeholder, finish: { (img, error) in
                    completion?(img,error,self);
                })
            }
        }
    }
}
