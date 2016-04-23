//
//  TMPJUserObject.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import UIKit
import CoreData

enum TMPJUserObjectRole : String
{
    case Waiter;
    case Cashier;
    case Manager;
    case Boos;
}

enum TMPJUserObjectGender : String
{
    case Unkown;
    case Boy;
    case Girl;
}

class TMPJUserObject: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var birthday: String?
    @NSManaged var avator: String?
    @NSManaged var userid: String?
    @NSManaged var shopid: String?
    @NSManaged var mobile: String?
    @NSManaged var regist_time: NSDate?
    @NSManaged var num_login: NSNumber?
    @NSManaged var str_role: String?
    @NSManaged var str_age: String?
    @NSManaged var str_sex: String?
    @NSManaged var add_time: NSDate?
    @NSManaged var token: String?
    
    var role:TMPJUserObjectRole{
        get {
            return TMPJUserObjectRole(rawValue: self.str_role!)!;
        }
        set(newval){
            self.str_role = newval.rawValue;
        }
    }
    
    var gender:TMPJUserObjectGender{
        get {
            return TMPJUserObjectGender(rawValue: self.str_sex!)!;
        }
        set(newval){
            self.str_sex = newval.rawValue;
        }
    }
    
    var islogin:Bool{
        get {
            return (self.num_login?.boolValue)!;
        }
        set (newval){
            self.num_login = NSNumber(bool: newval);
        }
    }
}
