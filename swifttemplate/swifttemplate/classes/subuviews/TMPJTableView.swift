//
//  TMPJTableView.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey
struct TMPJTableViewCommonReuseid:RawRepresentable{
    var rawValue: String
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    fileprivate static func common(_ cellClass:TMPJTableViewCell.Type)->TMPJTableViewCommonReuseid{
        return TMPJTableViewCommonReuseid(rawValue:NSStringFromClass(cellClass))
    }
}
protocol TMPJTableViewReuseableCell where Self:TMPJTableViewCell{
    associatedtype ReuseIdentifier where Self.ReuseIdentifier:RawRepresentable,Self.ReuseIdentifier.RawValue == String
    static var reuseids:[ReuseIdentifier]{get}
}
extension TMPJTableViewReuseableCell{
    static var reuseids:[TMPJTableViewCommonReuseid]{
        return [.common(self)]
    }
    var reuseid:ReuseIdentifier?{
        guard let str = self.reuseIdentifier else {
            return nil
        }
        return ReuseIdentifier(rawValue:str)
    }
}
class TMPJTableView: AMTableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .singleLine
        self.backgroundColor = .background
        self.separatorColor = .separator
        self.delaysContentTouches = false
        self.showsVerticalScrollIndicator = true
        self.alwaysBounceVertical = true
        self.estimatedRowHeight = 0
        self.estimatedSectionFooterHeight = 0
        self.estimatedSectionHeaderHeight = 0
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    func register<Cell:TMPJTableViewReuseableCell>(_ type:Cell.Type){
        for id  in type.reuseids {
            self.register(type, forCellReuseIdentifier: id.rawValue)
        }
    }
    func dequeueReusableCell<Cell:TMPJTableViewReuseableCell>(_ type:Cell.Type, with identifier:Cell.ReuseIdentifier,for indexPath:IndexPath)->Cell{
        return self.dequeueReusableCell(withIdentifier: identifier.rawValue, for: indexPath) as! Cell
    }
    func dequeueReusableCell<Cell:TMPJTableViewReuseableCell>(_ type:Cell.Type,for indexPath:IndexPath)->Cell where Cell.ReuseIdentifier == TMPJTableViewCommonReuseid{
        return self.dequeueReusableCell(type, with: .common(type), for: indexPath)
    }
}

