//
//  TMPJDBManager.m
//  objctemplate
//
//  Created by supertext on 15/3/11.
//  Copyright (c) 2015年 icegent. All rights reserved.
//

#import "TMPJSqliteManager.h"
#import <CoreData/CoreData.h>
#import <EasyTools/EasyTools.h>
@interface TMPJSqliteManager()
@property(nonatomic,strong)NSManagedObjectContext *mainContext;
@property(nonatomic,strong)NSManagedObjectContext *privateContext;
@property(nonatomic,strong)NSPersistentStoreCoordinator *pscoordinator;
@property(nonatomic,strong)NSManagedObjectModel *model;
@end

@implementation TMPJSqliteManager
+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static TMPJSqliteManager *_sharedManager;
    dispatch_once(&onceToken, ^{
        _sharedManager=[[super allocWithZone:nil] init];
    });
    return _sharedManager;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedManager];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        NSURL *modelURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"objctemplate" withExtension:@"momd"];
        
        self.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        self.pscoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        
        NSURL *storeURL = [NSURL fileURLWithPath:[ETDocumentsDirectory() stringByAppendingString:@"/objctemplate.sqlte"]];
        [self.pscoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
        
        self.mainContext.persistentStoreCoordinator = self.pscoordinator;
        self.privateContext.persistentStoreCoordinator = self.pscoordinator;
    }
    return self;
}

@end
