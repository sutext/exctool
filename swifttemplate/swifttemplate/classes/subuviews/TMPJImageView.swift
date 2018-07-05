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
        case avator = "?x-oss-process=style/lerjin_avatar_mini"
        case photo = "?x-oss-process=style/lerjin_photo_mini"
    }
    private var wconst:NSLayoutConstraint?
    private var hconst:NSLayoutConstraint?
    init() {
        super.init(frame: .zero)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    convenience init(w:CGFloat,h:CGFloat) {
        self.init()
        
        self.constraint(width: w, height: h)
    }
    convenience override init(image:UIImage?){
        self.init()
        self.image = image
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
        return nil
    }
    class func imageURL(for osskey:String,with style:Style = .none) -> String
    {
        return "http://img.okami.lerjin.com/\(osskey)\(style.rawValue)";
    }
    func setImage(url: AMURLConvertible?, style:Style = .none,scale:CGFloat = 3, completion: ((UIImage?, Error?, TMPJImageView) -> Void)? = nil) {
        guard let url = url?.url else {
            return
        }
        guard url.hasPrefix("http") else {
            let keyedURL = TMPJImageView.imageURL(for: url, with: style)
            self.setImage(with: keyedURL,scale:scale, placeholder: nil, finish: { (img, error) in
                completion?(img,error,self);
            })
            return
        }
        self.setImage(with: url, scale: scale, placeholder: nil) { (img, err) in
            completion?(img,err,self)
        }
    }
}
