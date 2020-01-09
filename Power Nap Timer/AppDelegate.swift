//
//  AppDelegate.swift
//  Power Nap Timer
//
//  Created by Jake Loresch on 1/20/19.
//  Copyright © 2019 Jake Loresch. All rights reserved.
//

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {(success, _) in
            if success {
                print("User allowed us to send alerts")
            }
            
        }
        
        return true
    }
}
