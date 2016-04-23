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
    private var privateContext:NSManagedObjectContext
    private var pscoordinator:NSPersistentStoreCoordinator
    private var model:NSManagedObjectModel
    static let sharedManager : TMPJSqliteManager = TMPJSqliteManager();
    
    private override init() {
        self.privateContext = NSManagedObjectContext(concurrencyType:.PrivateQueueConcurrencyType);
        let modelURL = NSBundle(forClass: TMPJSqliteManager.self).URLForResource("CoreTeahouse", withExtension: "momd")
        self.model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        self.pscoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        super.init()
        let storeURL = NSURL.fileURLWithPath("\(ETDocumentsDirectory())/CoreTeahouse.sqlte")
        let opions = [
            NSMigratePersistentStoresAutomaticallyOption:true,
            NSInferMappingModelAutomaticallyOption:true
        ];
        do {
            try self.pscoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: opions)
        }
        catch
        {
            try! NSFileManager.defaultManager().removeItemAtURL(storeURL);
            try! self.pscoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: opions)
        }
        self.privateContext.persistentStoreCoordinator = self.pscoordinator;
    }
    
    func saveContext()
    {
        self.privateContext.performBlockAndWait({ () -> Void in
            do{
                try self.privateContext.save();
            }
            catch
            {
                
            }
        })
    }
    
    func removeObject(objects:[NSManagedObject])
    {
        self.privateContext.performBlockAndWait { () -> Void in
            for object in objects
            {
                self.privateContext.deleteObject(object);
            }
        }
        self.saveContext();
    }

    func insertOrUpdate(entity:TMPJNetworkEntity?) -> TMPJUserObject?
    {
        if let userid = entity?.stringForKey("uid")
        {
            var user:TMPJUserObject?;
            self.privateContext.performBlockAndWait { () -> Void in
                user = self.queryUser(userid)
                if user == nil
                {
                    user = self.createUser(userid);
                }
                user!.str_age = entity?.stringForKey("age");
                user!.str_sex = entity?.stringForKey("sex");
                user!.str_role = entity?.stringForKey("role");
                user!.name = entity?.stringForKey("name");
                user!.token = entity?.stringForKey("token");
                user!.birthday = entity?.stringForKey("birthday");
                user!.avator = entity?.stringForKey("avator");
            }
            return user;
        }
        return nil;
    }
    func queryUser(userid:String) ->TMPJUserObject?
    {
        let request = NSFetchRequest(entityName: "TMPJUserObject");
        request.predicate = NSPredicate(format: "userid=%@", userid);
        let objects = try! self.privateContext.executeFetchRequest(request);
        return objects.first as? TMPJUserObject;
    }
    func createUser(userid:String) ->TMPJUserObject
    {
        let user:TMPJUserObject =  NSEntityDescription.insertNewObjectForEntityForName("TMPJUserObject", inManagedObjectContext: self.privateContext) as! TMPJUserObject;
        user.add_time = NSDate();
        user.userid = userid;
        return user;
    }

}
