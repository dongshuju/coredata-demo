//
//  CoreDataHelper.h
//  coredata-demo
//
//  Created by shujucn on 27/03/2018.
//  Copyright © 2018 shuju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define debug 1
#define PRINT_DEBUGINFO NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd))

@interface CoreDataHelper : NSObject

@property(nonatomic, readonly) NSManagedObjectContext *context;
@property(nonatomic, readonly) NSManagedObjectModel *model;
@property(nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property(nonatomic, readonly) NSPersistentStore *store;

-(void)setupCoreData;
-(void)saveContext;

@end
