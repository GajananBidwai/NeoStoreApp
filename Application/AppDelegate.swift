//
//  AppDelegate.swift
//  NeoStoreApp
//
//  Created by Neosoft on 24/06/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .red
//        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//        let backButtonImage = UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal)
//        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
//
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().tintColor = .red
//        UINavigationController().navigationItem.backBarButtonItem?.title = ""

        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedIn = UserDefaults.standard.bool(forKey: "is_login")
        
        if loggedIn {
            let HomeScreenViewController = storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
            let navigationController = UINavigationController(rootViewController: HomeScreenViewController)
            window?.rootViewController = navigationController
        }else{
            let LoginScreenViewController = storyboard.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
            let navigationController = UINavigationController(rootViewController: LoginScreenViewController)
            window?.rootViewController = navigationController
        }
        window?.makeKeyAndVisible()
        
        print("Database Path = \(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))")
        return true
    }
    func switchToLoginViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginScreenViewController = storyboard.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
            let navigationController = UINavigationController(rootViewController: loginScreenViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

        

    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NeoStoreApp")
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
