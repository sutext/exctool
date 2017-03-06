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
            do{
                try self.privateContext.save();
            }
            catch
            {
                
            }
        })
    }
    
    func removeObject(_ objects:[NSManagedObject])
    {
        self.privateContext.performAndWait { () -> Void in
            for object in objects
            {
                self.privateContext.delete(object);
            }
        }
        self.saveContext();
    }

    func insertOrUpdate(_ entity:TMPJNetworkEntity?) -> TMPJUserObject?
    {
        if let userid = entity?.string(forKey: "uid")
        {
            var user:TMPJUserObject?;
            self.privateContext.performAndWait { () -> Void in
                user = self.queryUser(userid)
                if user == nil
                {
                    user = self.createUser(userid);
                }
                user!.str_age = entity?.string(forKey: "age");
                user!.str_sex = entity?.string(forKey: "sex");
                user!.str_role = entity?.string(forKey: "role");
                user!.name = entity?.string(forKey: "name");
                user!.token = entity?.string(forKey: "token");
                user!.birthday = entity?.string(forKey: "birthday");
                user!.avator = entity?.string(forKey: "avator");
            }
            return user;
        }
        return nil;
    }
    func queryUser(_ userid:String) ->TMPJUserObject?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TMPJUserObject");
        request.predicate = NSPredicate(format: "userid=%@", userid);
        let objects = try! self.privateContext.fetch(request);
        return objects.first as? TMPJUserObject;
    }
    func createUser(_ userid:String) ->TMPJUserObject
    {
        let user:TMPJUserObject =  NSEntityDescription.insertNewObject(forEntityName: "TMPJUserObject", into: self.privateContext) as! TMPJUserObject;
        user.add_time = Date();
        user.userid = userid;
        return user;
    }

}
