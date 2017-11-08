//
//  TMPJPageableRequest.swfit
//  swifttemplate
//
//  Created by supertext on 17/5/18.
//  Copyright © 2016年 icegent. All rights reserved.
//

import Airmey
import Alamofire

class TMPJPageableRequest<DataModel>:TMPJRequest<DataModel> {
    var index:Int=0
    {
        didSet{
            self.set(param: self.index, forKey: "page")
        }
    }
    var size:Int=10
    {
        didSet{
            self.set(param: self.size, forKey: "size")
        }
    }
    init(_ path: TMPJRequestPath) {
        super.init(path, method: .get)
        self.set(param: 10, forKey: "size")
        self.set(param: 0, forKey: "page")
    }
}
