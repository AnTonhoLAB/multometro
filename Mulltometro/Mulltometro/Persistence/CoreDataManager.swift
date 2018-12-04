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
    case user = "User"
    case person = "Person"
    case car = "Car"
}

enum RequestType: String{
    case name = "name"
}

protocol CDManagerProtocol{
//    static func saveThis<T: NSManagedObject>(_ obj: T,_ managedType: ManagedType, completionHandler: @escaping(Error?) -> Void)
}

class CDManager: CDManagerProtocol{
//    ((Bool) -> Void)? = nil) -> Void
    static func saveThis<T: NSManagedObject>(_ obj: T, completionHandler: ((Error?) -> Void)? = nil) -> Void {
        let context = getContext()
        do {
            try context.save()
            obj.didSave()
            guard let completionHandler = completionHandler else { return }
            completionHandler(nil)
        } catch let err {
            print("Fatal ERROR")
            
            guard let completionHandler = completionHandler else { return }
            completionHandler(err)
        }
    }
    
    static func deleteThis<T>(_ obj: T, completionHandler: @escaping(Error) -> Void){
        
    }
    
    static func getSinlgeObject<T>(_ object: T, completionHandler: @escaping(Response<T>) -> Void) where T:NSManagedObject {
        
        let context: NSManagedObjectContext = getContext()
        let fetch = NSFetchRequest<T>()
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)
        fetch.entity = entityDescription
        do {
            let arrayOfFetch = try context.fetch(fetch)
            let response = arrayOfFetch[0]
            completionHandler(.success(response))
        } catch {
            completionHandler(.failure(error))
        }
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
    
    static func Object<T>() -> T where T: NSManagedObject{
        return T(context: getContext())
    }
    
    static func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}


