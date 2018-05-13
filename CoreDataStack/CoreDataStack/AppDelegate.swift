//
//  AppDelegate.swift
//  CoreDataStack
//
//  Created by shujucn on 2018/5/7.
//  Copyright © 2018 shuju. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func creatReaders(number: Int) -> () {
        guard let entity = NSEntityDescription.entity(forEntityName: "Reader", in: persistentContainer.viewContext) else {
            fatalError("Could not creat entity")
        }
        
        for i in 1...number {
            let reader = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            reader.setValue("Name reader: #\(i)", forKey:"name")
            reader.setValue(i * 20, forKey:"age")
        }
        
        saveContext()
    }
    
    func printReader() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reader")
        let sortDescriptor = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            if let results = try persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
                for result in results {
                    if let name = result.value(forKey: "name") as? String, let age = result.value(forKey: "age"){
                        print("Reader: '\(name)' with age \(age)")
                    }
                }
            }
        } catch {
            print("fetch request error")
        }
    }
    
    func creatBooks(number: Int) -> () {
        guard let entity = NSEntityDescription.entity(forEntityName: "Book", in: persistentContainer.viewContext) else {
            fatalError("Could not creat entity")
        }
        for i in 1...number {
            let book = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            book.setValue("Name book: #\(i)", forKey:"bookName")
            book.setValue(i < number / 2 ? "story" : "english", forKey:"category")
            book.setValue(NSDate(), forKey: "publicDate")
        }
        saveContext()
    }
    
    func printBooks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        let sortDescriptor = NSSortDescriptor(key: "category", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            if let results = try persistentContainer.viewContext.fetch(fetchRequest) as? [NSManagedObject] {
                for result in results {
                    if let name = result.value(forKey: "bookName"), let category = result.value(forKey: "category"){
                        print("Book: '\(name)' with age \(category)")
                    }
                }
            }
        } catch {
            print("fetch request error")
        }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        creatReaders(number: 10)
        printReader()
        
//        creatBooks(number: 10)
//        printBooks()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStack")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}

