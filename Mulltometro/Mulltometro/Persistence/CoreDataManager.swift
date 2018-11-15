//
//  CoreDataManager.swift
//  Mulltometro
//
//  Created by George Gomes on 10/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import CoreData
import UIKit

enum ManagedType: String {
    case person = "Person"
    case car = "Car"
}

enum RequestType: String{
    case name = "name"
}

protocol CDManagerProtocol{
    static func saveThis<T: NSManagedObject>(_ obj: T,_ managedType: ManagedType, completionHandler: @escaping(Error?) -> Void)
}

class CDManager: CDManagerProtocol{
    
    static func saveThis<T: NSManagedObject>(_ obj: T,_ managedType: ManagedType, completionHandler: @escaping(Error?) -> Void){
        let context = getContext()
        do {
            try context.save()
            completionHandler(nil)
        } catch let err {
            print("Fatal ERROR")
            completionHandler(err)
        }
    }
    
    static func deleteThis<T>(_ obj: T, completionHandler: @escaping(Error) -> Void){
        
    }
    
    static func fetchAll<T>(_ objectType: T, completionHandler: @escaping([T], Error?) -> Void) where T:NSManagedObject {
        let context = getContext()
        
        var fetchedResult: NSFetchedResultsController<T>!
        let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T> //Person.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResult = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResult.delegate = UIViewController() as? NSFetchedResultsControllerDelegate
        
        do {
            try fetchedResult.performFetch()
            completionHandler(fetchedResult.fetchedObjects ?? [], nil)
        } catch let err {
            print(err)
            completionHandler([],err)
        }
    }
    
    static func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func Object<T>() -> T where T: NSManagedObject{
        return T(context: getContext())
    }
}

