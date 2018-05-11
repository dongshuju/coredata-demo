//
//  AppDelegate.h
//  Coredata-stack-objc
//
//  Created by shujucn on 2018/5/8.
//  Copyright © 2018 shuju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

