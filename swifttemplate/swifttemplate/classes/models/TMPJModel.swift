//
//  TMPJModel.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey

import Airmey

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
    func floatValue(forKey key:String) -> Float
    func stringValue(forKey key: String) -> String
    
    var isNull:Bool{get}
}
protocol TMPJModel {
    init(_ object:TMPJDynamicObject)
    var isNull:Bool{get}
}

extension AMJson:TMPJDynamicObject
{
    func bool(forKey key: String) -> Bool? {
        let node = self[key]
        switch node {
        case .bool(let value):
            return value
        case .number(let value):
            return value.boolValue
        case .string(let value):
            return Bool(value)
        default:
            return nil
        }
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
        return self[key].numberValue.intValue
    }
    func int64Value(forKey key: String) -> Int64 {
        return self[key].numberValue.int64Value
    }
    func floatValue(forKey key: String) -> Float {
        return self[key].numberValue.floatValue
    }
    func boolValue(forKey key: String) -> Bool {
        
        return self[key].boolValue
    }
    func int(forKey key: String) -> Int? {
        return self[key].number?.intValue
    }
    func int64(forKey key: String) -> Int64? {
        return self[key].number?.int64Value
    }
    func string(forKey key: String) -> String? {
        return self[key].string
    }
    func double(forKey key: String) -> Double? {
        return self[key].number?.doubleValue
    }
    func float(forKey key: String) -> Float? {
        return self[key].number?.floatValue
    }
    var isNull: Bool{
        if case .null = self {
            return true
        }
        return false
    }
}
public class TMPJNetworkObject:NSObject,TMPJDynamicObject,NSCoding{
    fileprivate let json:AMJson
    public required init(_ jsonObject:Any? = nil) {
        guard let object = jsonObject else {
            self.json = .null
            return
        }
        switch object {
        case let string as String:
            self.json = AMJson.parse(string)
        case let data as Data:
            self.json = AMJson.parse(data)
        default:
            self.json = AMJson(object)
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
    func floatValue(forKey key: String) -> Float {
        return self.json.floatValue(forKey:key)
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
            return ary.compactMap({ (obj) -> T? in
                let t = T(obj)
                return t.isNull ? nil : t
            })
        }
        return []
    }
    public required init?(coder aDecoder: NSCoder) {
        guard let data = aDecoder.decodeObject(forKey: "json") as? Data else{
            self.json = .null
            return
        }
        self.json = AMJson.parse(data)
    }
    public func encode(with aCoder: NSCoder) {
        if let data = json.rawData{
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
        return self.json.debugDescription
    }
}
