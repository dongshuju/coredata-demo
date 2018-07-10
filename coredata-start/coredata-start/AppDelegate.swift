//
//  AppDelegate.swift
//  coredata-start
//
//  Created by shujucn on 2018/5/7.
//  Copyright © 2018 shuju. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        creatTestDataIfNeed()
        createRelationship()
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
    }

    // MARK: - Core Data stack iOS 10
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
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
    
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "Relationship", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("Relationship.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func saveManagedObjectContext () {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Creat Demo Data
    
    func creatTestDataIfNeed() {
        
        guard (try! self.persistentContainer.viewContext.fetch(Library.fetchRequest()) as? [Library]) != nil else {
            fatalError("Could not creat entity")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Book", in: persistentContainer.viewContext) else {
            fatalError("Could not creat entity")
        }
        
        guard let librayEntity = NSEntityDescription.entity(forEntityName: "Library", in: persistentContainer.viewContext) else {
            fatalError("Could not creat entity")
        }
        
        
            let library1 = NSManagedObject(entity: librayEntity, insertInto: self.persistentContainer.viewContext) as! Library
            library1.name = "English Lib"
            
            for i in 1...10 {
                let book = NSManagedObject(entity: entity, insertInto: self.persistentContainer.viewContext) as! Book
                book.name = "English Book series: #\(i)"
                book.publicDate = Date() as NSDate
                book.category = "English"
                book.library = library1
            }
            
            let library2 = NSManagedObject(entity: librayEntity, insertInto: self.persistentContainer.viewContext) as! Library
            library2.name = "Math Lib"
            for i in 1...10 {
                let book = NSManagedObject(entity: entity, insertInto: self.persistentContainer.viewContext) as! Book
                book.name = "Math Book series: #\(i)"
                book.publicDate = Date() as NSDate
                book.category = "Math"
                book.library = library2
            }
        
        
        if self.persistentContainer.viewContext.hasChanges {
            self.saveContext()
        }
    }
    
    
    func createRelationship() {
        
        guard let gradeEntity = NSEntityDescription.entity(forEntityName: "Grade", in: managedObjectContext) else {
            fatalError("Could not creat entity")
        }
        
        guard let studentEntity = NSEntityDescription.entity(forEntityName: "Student", in: managedObjectContext) else {
            fatalError("Could not creat entity")
        }
    
        guard let teacderEntity = NSEntityDescription.entity(forEntityName: "Teacher", in: managedObjectContext) else {
            fatalError("Could not creat entity")
        }
        
        // creat grade NSManagedObject
        let grade1 = NSManagedObject(entity: gradeEntity, insertInto: managedObjectContext) as! Grade
        grade1.name = "grade--1"
        
        
         let grade2 = NSManagedObject(entity: gradeEntity, insertInto: managedObjectContext) as! Grade
        grade2.name = "grade--2"
        
        let grade3 = NSManagedObject(entity: gradeEntity, insertInto: managedObjectContext) as! Grade
        grade3.name = "grade--3"
        
        //creat teachers
        let teacherA = NSManagedObject(entity: teacderEntity, insertInto: managedObjectContext) as! Teacher
        teacherA.name = "teacher--A"
        
        let teacherB = NSManagedObject(entity: teacderEntity, insertInto: managedObjectContext) as! Teacher
        teacherB.name = "teacher--B"
        
        let teacherC = NSManagedObject(entity: teacderEntity, insertInto: managedObjectContext) as! Teacher
        teacherC.name = "teacher--C"
        
        // creat students
        let student001 = NSManagedObject(entity: studentEntity, insertInto: managedObjectContext) as! Student
        student001.name = "student--001"
        
        let student002 = NSManagedObject(entity: studentEntity, insertInto: managedObjectContext) as! Student
        student002.name = "student--002"
        
        let student003 = NSManagedObject(entity: studentEntity, insertInto: managedObjectContext) as! Student
        student003.name = "student--003"
        
        let student004 = NSManagedObject(entity: studentEntity, insertInto: managedObjectContext) as! Student
        student004.name = "student--004"

        
        //creat relationship
        student001.gradeLevel = grade1
        student002.gradeLevel = grade2
        student003.gradeLevel = grade3
        
        
        student001.teachers.insert(teacherC)
        student001.teachers.insert(teacherA)
        
        student002.teachers.insert(teacherB)
        student002.teachers.insert(teacherA)
        
        student003.teachers.insert(teacherB)
        student003.teachers.insert(teacherC)
        
        grade1.teachers.insert(teacherA)
        grade1.teachers.insert(teacherC)
        
        grade2.teachers.insert(teacherB)
        grade2.teachers.insert(teacherA)
        
        grade3.teachers.insert(teacherB)
        grade3.teachers.insert(teacherC)
        
        grade3.students.insert(student004)
        
        teacherA.grades?.insert(grade1)
        teacherA.grades?.insert(grade2)
        
        teacherB.grades?.insert(grade3)
        teacherB.grades?.insert(grade2)
        
        teacherC.grades?.insert(grade1)
        teacherC.grades?.insert(grade3)
        teacherC.grades?.insert(grade2)
        
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Save context error")
        }
        
        let grades = try! managedObjectContext.fetch(Grade.fetchRequest()) as! [Grade]
        for grade in grades {
            print("grade name: \(String(describing: grade.name)), grade students")
            grade.printStudents()
        }
    }
}

