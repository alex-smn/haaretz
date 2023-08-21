//
//  AppDelegate.swift
//  haAretzHome
//
//  Created by Alexander Livshits on 21/08/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = NewsViewController(NewsViewModel())
        window?.makeKeyAndVisible()
        return true
    }
}

