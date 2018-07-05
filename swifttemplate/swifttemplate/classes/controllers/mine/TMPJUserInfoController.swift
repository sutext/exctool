//
//  TMPJUserInfoController.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import UIKit

class TMPJUserInfoController: TMPJTableViewController {
    private let account:String
    init(_ account:String = global.account){
        self.account = account
        super.init(style: .grouped)
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
