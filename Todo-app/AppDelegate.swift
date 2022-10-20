//
//  AppDelegate.swift
//  Todo-app
//
//  Created by Infinity Code on 10/13/22.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)

        
        do {
            _ = try Realm()

        } catch {
            print("Error initializing new realm, \(error)")
        }

        return true
    }
    

}

