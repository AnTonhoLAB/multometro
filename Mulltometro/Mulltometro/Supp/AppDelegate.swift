//
//  AppDelegate.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        
        let param = [
            "email": "georgegomees@gmail.com",
            "password": "SolMaior"
            ]
        
        HTTPRequester.request(route: .auth, function: .login, parameters: param, completion: { response in 
            
        })
        
        let launchedBefore = UserDefaults.standard.bool(forKey: R.string.strings.launchedBefore())
        
        if !launchedBefore  { //First time in app
            AuthManager.eraseLogData()
            UserDefaults.standard.set(true, forKey: R.string.strings.launchedBefore())
        }

        if !AuthManager.isLogged() {
            let rootController = R.storyboard.login().instantiateViewController(withIdentifier: R.string.strings.loginIdentifier())
            self.window?.rootViewController = rootController
        }

        //Apparece
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Mulltometro")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

