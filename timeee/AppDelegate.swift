//
//  AppDelegate.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/16.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate{


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (granted, error) in
                
                if granted {
                    print("Allowed")
                }
                else {
                    print("Not Allowed")
                }
            }
            
            let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
            let dislikeAction = UNNotificationAction(identifier: "Stop", title: "Stop", options: [])
            let category = UNNotificationCategory(identifier: "alarmMessage", actions: [snoozeAction, dislikeAction], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([category])
            
            UNUserNotificationCenter.current().delegate = self
            return true
        }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

            completionHandler([.alert, .sound, .badge])
        }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

