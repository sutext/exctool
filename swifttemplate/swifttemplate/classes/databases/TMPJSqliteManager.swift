//
//  TMPJSqliteManager.swift
//  swifttemplate
//
//  Created by supertext on 15/3/11.
//  Copyright © 2016年 icegent. All rights reserved.
//

import EasyTools
import CoreData
import Foundation

protocol TMPJObjectProtocol {
    static var primaryKey:String{get}
    func setup(for entity:TMPJNetworkEntity?)
}

final class TMPJSqliteManager: NSObject {
    fileprivate var privateContext:NSManagedObjectContext
    fileprivate var pscoordinator:NSPersistentStoreCoordinator
    fileprivate var model:NSManagedObjectModel
    static let sharedManager : TMPJSqliteManager = TMPJSqliteManager();
    
    fileprivate override init() {
        self.privateContext = NSManagedObjectContext(concurrencyType:.privateQueueConcurrencyType);
        let modelURL = Bundle(for: TMPJSqliteManager.self).url(forResource: "CoreTeahouse", withExtension: "momd")
        self.model = NSManagedObjectModel(contentsOf: modelURL!)!
        self.pscoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        super.init()
        let storeURL = URL(fileURLWithPath:"\(ETDocumentsDirectory())/CoreTeahouse.sqlte");
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
    func insertUpdate<Object:NSManagedObject>(_ type:Object.Type,entity:TMPJNetworkEntity?)->Object? where Object:TMPJObjectProtocol
    {
        if let value = entity?.string(forKey: Object.primaryKey)
        {
            var obj:Object?
            self.privateContext.performAndWait {
                //search
                let className = NSStringFromClass(type)
                let request = NSFetchRequest<Object>(entityName: className);
                request.predicate = NSPredicate(format: "\(Object.primaryKey)=%@",value);
                obj = (try? self.privateContext.fetch(request))?.first;
                
                if obj == nil
                {
                    //create
                    obj = NSEntityDescription.insertNewObject(forEntityName: className, into: self.privateContext) as? Object
                    obj?.setValue(value, forKey: Object.primaryKey);
                }
                obj?.setup(for: entity);
                try? self.privateContext.save();
            }
            return obj
        }
        return nil;
    }
    func insertUpdate<Object:NSManagedObject>(_ type:Object.Type,entitys:[TMPJNetworkEntity]?)->[Object] where Object:TMPJObjectProtocol
    {
        var objects:[Object] = [];
        if let ents = entitys {
            self.privateContext.performAndWait {
                for entity in ents {
                    let value = entity.string(forKey: Object.primaryKey)
                    var obj:Object?
                    
                    //search
                    let className = NSStringFromClass(type)
                    let request = NSFetchRequest<Object>(entityName: className);
                    request.predicate = NSPredicate(format: "\(Object.primaryKey)=%@",value);
                    obj = (try? self.privateContext.fetch(request))?.first;
                    
                    if obj == nil
                    {
                        //create
                        obj = NSEntityDescription.insertNewObject(forEntityName: className, into: self.privateContext) as? Object
                        obj?.setValue(value, forKey: Object.primaryKey);
                    }
                    obj?.setup(for: entity);
                    if let o = obj
                    {
                        objects.append(o);
                    }
                }
                try? self.privateContext.save();
            }
        }
        return objects;
    }
    func query<Object:NSManagedObject>(one type:Object.Type,for key:String)->Object? where Object:TMPJObjectProtocol
    {
        return self.query(list: type, predicate: NSPredicate(format: "\(Object.primaryKey)=%@",key)).first
    }
    func query<Object:NSManagedObject>(list type:Object.Type,predicate:NSPredicate,sorts:[NSSortDescriptor]? = nil)->[Object] where Object:TMPJObjectProtocol
    {
        let className = NSStringFromClass(type)
        let request = NSFetchRequest<Object>(entityName: className);
        request.predicate = predicate;
        request.sortDescriptors = sorts;
        let objs = try? self.privateContext.fetch(request);
        return objs ?? []
    }
    func query<Object:NSManagedObject>(all type:Object.Type)->[Object] where Object:TMPJObjectProtocol
    {
        let className = NSStringFromClass(type)
        let request = NSFetchRequest<Object>(entityName: className);
        let objs = try? self.privateContext.fetch(request)
        return objs ?? []
    }

}
