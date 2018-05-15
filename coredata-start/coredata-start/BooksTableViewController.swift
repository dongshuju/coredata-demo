//
//  ReaderTableViewController.swift
//  coredata-start
//
//  Created by shujucn on 2018/5/8.
//  Copyright © 2018 shuju. All rights reserved.
//

import UIKit
import CoreData

class BooksTableViewController: UITableViewController {

    var viewContext: NSManagedObjectContext!
    
    var books:[Book]?
    
    var fetchedResultsController: NSFetchedResultsController<Book>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Books"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.viewContext = appDelegate.persistentContainer.viewContext
        self.navigationController?.navigationItem.title = "Books"
        do {
            let request = NSFetchRequest<Book>(entityName: "Book")

            let results = try appDelegate.persistentContainer.viewContext.fetch(request)
            for result in results {
                if let name = result.name, let category = result.category {
                    print("Got book \(category) with name \(name)")
                }
            }
            books = results
        } catch {
            print("fetch request error")
        }
        
        let fetchRequest = NSFetchRequest<Book>(entityName: "Book")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.viewContext, sectionNameKeyPath: "category", cacheName: "CacheName.Library")
        self.fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.userInfo)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (fetchedResultsController.sections?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (fetchedResultsController.sections?[section].numberOfObjects) ?? 0
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultsController.sections![section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCellReuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.detailTextLabel?.text = fetchedResultsController.object(at: indexPath).category
        cell.textLabel?.text = fetchedResultsController.object(at: indexPath).name
        
        return cell
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
        viewContext.delete(fetchedResultsController.object(at: indexPath))
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
}

extension BooksTableViewController: NSFetchedResultsControllerDelegate
{
    /// MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default: break
        }
        self.tableView.reloadData()
    }
}
