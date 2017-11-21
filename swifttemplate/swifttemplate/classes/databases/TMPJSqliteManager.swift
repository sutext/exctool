//
//  TMPJSqliteManager.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2015年 icegent. All rights reserved.
//

import Airmey
import CoreData
import Foundation

protocol TMPJDynamicObjectConvertible where Self:NSManagedObject{
    static var primaryKey:String{get}
    func setup(_ model:TMPJDynamicObject)
}
protocol TMPJFetchPropertyConfigurable where Self:NSManagedObject{
    static var isConfiged:Bool{get set}
    static func config(for entity:NSEntityDescription)
}

final class TMPJSqliteManager: NSObject {
    fileprivate var privateContext:NSManagedObjectContext
    private var pscoordinator:NSPersistentStoreCoordinator
    private var model:NSManagedObjectModel
    static let shared: TMPJSqliteManager = TMPJSqliteManager();
    
    private override init() {
        self.privateContext = NSManagedObjectContext(concurrencyType:.privateQueueConcurrencyType);
        let modelURL = Bundle(for: TMPJSqliteManager.self).url(forResource: "CoreKaraok", withExtension: "momd")
        self.model = NSManagedObjectModel(contentsOf: modelURL!)!
        self.pscoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        super.init()
        
        let storeURL = URL(fileURLWithPath:"\(String.documentPath)/swifttemplate.sqlte");
        let opions = [
            NSMigratePersistentStoresAutomaticallyOption:true,
            NSInferMappingModelAutomaticallyOption:true
        ];
        do {
            try self.pscoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: opions)
        }
        catch
        {
            try! FileManager.default.removeItem(at: storeURL);
            try! self.pscoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: opions)
        }
        self.privateContext.persistentStoreCoordinator = self.pscoordinator;
        
    }
    func setup(){
        for entity in self.model.entities{
            guard let type = NSClassFromString(entity.managedObjectClassName) else{
                return
            }
            if let configType = type as? TMPJFetchPropertyConfigurable.Type{
                configType.config(for: entity)
            }
        }
    }
    func saveContext()
    {
        self.privateContext.performAndWait({ () -> Void in
            try? self.privateContext.save();
        })
    }
    
    func remove(objects:[NSManagedObject]?)
    {
        if let objs = objects {
            self.privateContext.performAndWait { () -> Void in
                for object in objs
                {
                    self.privateContext.delete(object);
                }
                try? self.privateContext.save();
            }
        }
    }
    
}

//MARK:query methods
extension TMPJSqliteManager
{
    func query<Object:TMPJDynamicObjectConvertible>(one type:Object.Type,for keyValue:String)->Object?
    {
        return self.query(list: type, predicate: NSPredicate(format: "\(Object.primaryKey)=%@",keyValue)).first
    }
    func query<Object:NSManagedObject>(list type:Object.Type,predicate:NSPredicate,pageIndex:Int,sorts:[NSSortDescriptor]? = nil)->[Object]
    {
        let className = NSStringFromClass(type)
        let request = NSFetchRequest<Object>(entityName: className);
        request.predicate = predicate;
        request.sortDescriptors = sorts;
        request.fetchLimit = 10
        request.fetchOffset = 10 * pageIndex
        let objs = try? self.privateContext.fetch(request);
        return objs ?? []
    }
    func query<Object:NSManagedObject>(list type:Object.Type,predicate:NSPredicate,sorts:[NSSortDescriptor]? = nil)->[Object]
    {
        let className = NSStringFromClass(type)
        let request = NSFetchRequest<Object>(entityName: className);
        request.predicate = predicate;
        request.sortDescriptors = sorts;
        let objs = try? self.privateContext.fetch(request);
        return objs ?? []
    }
    func query<Object:NSManagedObject>(all type:Object.Type)->[Object]
    {
        let className = NSStringFromClass(type)
        let request = NSFetchRequest<Object>(entityName: className);
        let objs = try? self.privateContext.fetch(request)
        return objs ?? []
    }
    func count<Object:NSManagedObject>(for type:Object.Type,predicate:NSPredicate?=nil)->Int{
        let className = NSStringFromClass(type)
        let request = NSFetchRequest<Object>(entityName: className)
        request.predicate = predicate
        let count = try? self.privateContext.count(for: request)
        return count ?? 0
    }
}
//MARK:insert update methods
extension TMPJSqliteManager
{
    func insert<Object:NSManagedObject>(_ type:Object.Type) -> Object {
        return NSEntityDescription.insertNewObject(forEntityName: NSStringFromClass(type), into: self.privateContext) as! Object
    }
    func insertUpdate<Object:TMPJDynamicObjectConvertible>(_ type:Object.Type,object:TMPJDynamicObject)->Object?
    {
        guard !object.isNull else {
            return nil
        }
        if let value = object.string(forKey: Object.primaryKey)
        {
            var obj:Object?
            self.privateContext.performAndWait {
                obj = self.generateObject(type, keyValue: value);
                obj?.setup(object);
                do {
                    try self.privateContext.save();
                }
                catch{
                    print(error.localizedDescription)
                }
            }
            return obj
        }
        return nil;
    }
    func insertUpdate<Object:TMPJDynamicObjectConvertible>(_ type:Object.Type,objects:[TMPJDynamicObject]?)->[Object]
    {
        var results:[Object] = [];
        self.privateContext.performAndWait {
            results = self.generateObjects(type, objects: objects)
            try? self.privateContext.save();
        }
        return results;
    }
    func createToken()->TMPJTokenObject
    {
        var config:TMPJTokenObject?
        self.privateContext.performAndWait {
            config = self.generateObject(TMPJTokenObject.self, keyValue: TMPJTokenObject.pkeyValue);
            try? self.privateContext.save();
        }
        return config!
    }
    func obtainAsset(for account:String) -> TMPJAssetObject {
        var asset:TMPJAssetObject?
        self.privateContext.performAndWait {
            asset = self.generateObject(TMPJAssetObject.self, keyValue: account);
            try? self.privateContext.save();
        }
        return asset!
    }
}
//MARK:private methods
extension TMPJSqliteManager
{
    fileprivate func generateObjects<Object:TMPJDynamicObjectConvertible>(_ type:Object.Type,objects:[TMPJDynamicObject]?)->[Object]
    {
        var results:[Object] = [];
        if let objects = objects {
            for object in objects {
                guard !object.isNull else{continue}
                if let value = object.string(forKey: Object.primaryKey)
                {
                    let obj:Object=self.generateObject(type, keyValue: value);
                    obj.setup(object);
                    results.append(obj);
                }
            }
        }
        return results;
    }
    func generateObject<Object:TMPJDynamicObjectConvertible>(_ type:Object.Type,keyValue:String)->Object
    {
        var obj:Object?
        //search
        let className = NSStringFromClass(type)
        let request = NSFetchRequest<Object>(entityName: className);
        request.predicate = NSPredicate(format: "\(Object.primaryKey)=%@",keyValue);
        obj = (try? self.privateContext.fetch(request))?.first;
        
        if obj == nil
        {
            //create
            obj = NSEntityDescription.insertNewObject(forEntityName: className, into: self.privateContext) as? Object
            obj?.setValue(keyValue, forKey: Object.primaryKey);
        }
        return obj!
    }
}
final class TMPJSqliteService {
    static let shared = TMPJSqliteService()
    private let sqlite = TMPJSqliteManager.shared
    private let queue = DispatchQueue(label: "com.icegent.swifttemplate.sqlite.queue")
    private init(){}
    func saveContext()
    {
        self.queue.async {
            self.sqlite.saveContext();
        }
    }
    
    func remove(objects:[NSManagedObject]?)
    {
        self.queue.async {
            self.sqlite.remove(objects: objects)
        }
    }
    
    func insertUpdate<Object:TMPJDynamicObjectConvertible>(_ type:Object.Type,object:TMPJDynamicObject,block:((Object?) ->Void)? = nil)
    {
        self.queue.async {
            let obj = self.sqlite.insertUpdate(type, object: object)
            DispatchQueue.main.async {
                block?(obj)
            }
        }
    }
    func insertUpdate<Object:TMPJDynamicObjectConvertible>(_ type:Object.Type,objects:[TMPJDynamicObject]?,block:(([Object])->Void)? = nil)
    {
        self.queue.async {
            let objs = self.sqlite.insertUpdate(type, objects: objects)
            DispatchQueue.main.async {
                block?(objs)
            }
        }
    }
    func query<Object:TMPJDynamicObjectConvertible>(one type:Object.Type,for keyValue:String,block:((Object?) ->Void)?)
    {
        self.queue.async {
            let obj = self.sqlite.query(one: type, for: keyValue)
            DispatchQueue.main.async {
                block?(obj)
            }
        }
    }
    func query<Object:NSManagedObject>(list type:Object.Type,predicate:NSPredicate,sorts:[NSSortDescriptor]? = nil,block:(([Object])->Void)?)
    {
        self.queue.async {
            let objs = self.sqlite.query(list: type, predicate: predicate, sorts: sorts)
            DispatchQueue.main.async {
                block?(objs)
            }
        }
    }
    func query<Object:NSManagedObject>(all type:Object.Type,block:(([Object])->Void)?)
    {
        self.queue.async {
            let objs = self.sqlite.query(all: type)
            DispatchQueue.main.async {
                block?(objs)
            }
        }
    }
}

