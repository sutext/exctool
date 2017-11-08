//
//  TMPJModel.swift
//  swifttemplate
//
//  Created by supertext on 2017/11/8.
//  Copyright © 2017年 icegent. All rights reserved.
//

import JSON

protocol TMPJDynamicObject {
    func int(forKey key:String)-> Int?
    func bool(forKey key:String)-> Bool?
    func int64(forKey key:String) -> Int64?
    func float(forKey key:String)-> Float?
    func array(forKey key:String)-> [TMPJDynamicObject]?
    func double(forKey key:String)-> Double?
    func string(forKey key: String) -> String?
    func object(forKey key:String)-> TMPJDynamicObject?
    
    func array() ->[TMPJDynamicObject]?
    func stringValue()->String
    
    func intValue(forKey key:String) ->Int
    func boolValue(forKey key:String) ->Bool
    func int64Value(forKey key:String) -> Int64
    func stringValue(forKey key: String) -> String
    
    var isNull:Bool{get}
}
protocol TMPJModel {
    init(_ object:TMPJDynamicObject)
    var isNull:Bool{get}
}

extension JSON:TMPJDynamicObject
{
    func bool(forKey key: String) -> Bool? {
        let node = self[key]
        if let bool = node.bool{
            return bool
        }
        if let number = node.number{
            return number.boolValue
        }
        if let bool = Bool(node.stringValue){
            return bool
        }
        return nil
    }
    func stringValue() -> String {
        return self.stringValue
    }
    func array() -> [TMPJDynamicObject]? {
        return self.array
    }
    func stringValue(forKey key: String) -> String {
        return self[key].stringValue
    }
    func object(forKey key: String) -> TMPJDynamicObject? {
        let object = self[key]
        if object.isNull {
            return nil
        }
        return object
    }
    func array(forKey key: String) -> [TMPJDynamicObject]? {
        
        return self[key].array
    }
    func intValue(forKey key: String) -> Int {
        return self[key].intValue
    }
    func int64Value(forKey key: String) -> Int64 {
        return self[key].int64Value
    }
    func boolValue(forKey key: String) -> Bool {
        
        return self[key].boolValue
    }
    func int(forKey key: String) -> Int? {
        if let intval =  self[key].int{
            return intval
        }
        if let intval = Int(self[key].stringValue)
        {
            return intval
        }
        return nil;
    }
    func int64(forKey key: String) -> Int64? {
        
        if let intval =  self[key].int64{
            return intval
        }
        if let intval = Int64(self[key].stringValue)
        {
            return intval
        }
        return nil
    }
    func string(forKey key: String) -> String? {
        if let str = self[key].string {
            return str;
        }
        if let num = self[key].number{
            return num.stringValue
        }
        return nil
    }
    func double(forKey key: String) -> Double? {
        if let dval =  self[key].double{
            return dval
        }
        if let dval = Double(self[key].stringValue)
        {
            return dval
        }
        return nil
    }
    func float(forKey key: String) -> Float? {
        if let floatval =  self[key].float{
            return floatval
        }
        if let floatval = Float(self[key].stringValue)
        {
            return floatval
        }
        return nil
        
    }
    var isNull: Bool{
        return self.type == .null
    }
}
public class TMPJNetworkObject:NSObject,TMPJDynamicObject,NSCoding{
    fileprivate let json:JSON
    public required init(_ jsonObject:Any? = nil) {
        guard let object = jsonObject else {
            self.json = JSON(NSNull())
            return
        }
        switch object {
        case let string as String:
            self.json = JSON(parseJSON: string)
        case let json as JSON:
            self.json = json
        default:
            self.json = JSON(object)
        }
    }
    var isNull: Bool{
        return self.json.isNull
    }
    func stringValue() -> String {
        return self.json.stringValue()
    }
    func array() -> [TMPJDynamicObject]?{
        return self.json.array()
    }
    func bool(forKey key: String) -> Bool? {
        return self.json.bool(forKey:key)
    }
    func object(forKey key: String) -> TMPJDynamicObject? {
        return self.json.object(forKey:key)
    }
    func array(forKey key: String) -> [TMPJDynamicObject]? {
        return self.json.array(forKey:key)
    }
    func int(forKey key: String) -> Int? {
        return self.json.int(forKey:key);
    }
    func int64(forKey key: String) -> Int64? {
        return self.json.int64(forKey:key)
    }
    
    func int64Value(forKey key: String) -> Int64 {
        return self.json.int64Value(forKey:key)
    }
    func string(forKey key: String) -> String? {
        return self.json.string(forKey:key)
    }
    func double(forKey key: String) -> Double? {
        return self.json.double(forKey:key)
    }
    func float(forKey key: String) -> Float? {
        return self.json.float(forKey:key)
    }
    func intValue(forKey key: String) -> Int {
        return self.json.intValue(forKey:key)
    }
    func boolValue(forKey key: String) -> Bool{
        return self.json.boolValue(forKey:key)
    }
    func stringValue(forKey key: String) -> String {
        return self.json.stringValue(forKey:key)
    }
    class func map<T:TMPJModel>(_ type:T.Type , ary:[TMPJDynamicObject]?)->[T]
    {
        if let ary = ary
        {
            return ary.flatMap({ (obj) -> T? in
                let t = T(obj)
                return t.isNull ? nil : t
            })
        }
        return []
    }
    public required init?(coder aDecoder: NSCoder) {
        guard let data = aDecoder.decodeObject(forKey: "json") as? Data else{
            self.json = JSON(NSNull())
            return
        }
        self.json = JSON(data)
    }
    public func encode(with aCoder: NSCoder) {
        
        if let data = try? self.json.rawData(){
            aCoder.encode(data, forKey: "json")
        }
    }
}

extension TMPJNetworkObject
{
    override public var description: String{
        return self.json.description
    }
    override public var debugDescription: String{
        return self.json.description
    }
}
