//
//  CoreDataHelper.m
//  coredata-demo
//
//  Created by shujucn on 27/03/2018.
//  Copyright © 2018 shuju. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper

#pragma mark FILES
static NSString *storeFilename = @"shujucn-user.sqlite";

#pragma mark PATHS
-(NSString *)applicationDocumentsDirectory {
    if (debug == 1) {
        PRINT_DEBUGINFO;
    }
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSURL *)applicationStoresDirectory {
    if (debug == 1) {
        PRINT_DEBUGINFO;
    }
    
    NSURL *storeDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]] URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[storeDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storeDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error]) {
            
            if (debug == 1) {
                NSLog(@"Success created Stores directory");
            }
        } else {
            NSLog(@"Fail created Stores directory");
        }
    }
    
    return storeDirectory;
}
-(NSURL *)storeUrl {
    if (debug == 1) {
        PRINT_DEBUGINFO;
    }
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

#pragma mark SETUP
-(instancetype)init {
    if (debug == 1) {
        PRINT_DEBUGINFO;
    }
    self = [super init];
    if (self) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    }
    return self;
}

-(void)loadStore {
    if (debug == 1) {
        PRINT_DEBUGINFO;
    }
    
    if (_store) { return; }
    
    NSError *error = nil;
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                        configuration:nil
                                                  URL:[self storeUrl]
                                              options:nil
                                                error:&error];
    
    if (!_store) {
        NSLog(@"Fail to add store, error: %@", error);
    } else {
        if (debug == 1) {
            NSLog(@"Success add store: %@", _store);
        }
    }
    
}

-(void)setupCoreData {
    if (debug == 1) {
        PRINT_DEBUGINFO;
    }
    [self loadStore];
}

#pragma mark SAVING
-(void)saveContext {
    if (debug == 1) {
        PRINT_DEBUGINFO;
    }
    
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"Success save context %@", _context);
        } else {
            NSLog(@"Fail save context %@", _context);
        }
    } else {
        NSLog(@"There are no changes to save");
    }
    
}


@end
