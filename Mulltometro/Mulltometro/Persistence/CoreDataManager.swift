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
        fetchAll(object) { (arr, err) in
            if let err = err {
                completionHandler(.failure(err))
            } else {
                guard let user = arr.last else { completionHandler(.failure(SaveUserError.errorOnUser)); return }
                completionHandler(.success(user))
            }
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
    
    static func logout(completion: @escaping(Response<Bool>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try  getContext().execute(deleteRequest)
            completion(.success(true))
            //myPersistentStoreCoordinator.executeRequest(deleteRequest, withContext: getContext())
        } catch {
            completion(.failure(error))
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


