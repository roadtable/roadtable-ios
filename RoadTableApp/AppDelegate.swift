//
//  AppDelegate.swift
//  RoadTableApp
//
//  Created by Caleb Francis on 9/2/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Request permission to use location
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        // Notification actions
        let toGoogleMapsAction = UIMutableUserNotificationAction()
        toGoogleMapsAction.identifier = "routeTo"
        toGoogleMapsAction.title = "Take me there!"
        toGoogleMapsAction.activationMode = UIUserNotificationActivationMode.Background
        toGoogleMapsAction.destructive = true
        toGoogleMapsAction.authenticationRequired = false
        
        let cancelUpcomingStopAction = UIMutableUserNotificationAction()
        cancelUpcomingStopAction.identifier = "cancelStop"
        cancelUpcomingStopAction.title = "Skip"
        cancelUpcomingStopAction.activationMode = UIUserNotificationActivationMode.Background
        cancelUpcomingStopAction.destructive = true
        cancelUpcomingStopAction.authenticationRequired = false
        
        // Category
        let routeNotificationCategory = UIMutableUserNotificationCategory()
        routeNotificationCategory.identifier = "routeCategory"
        routeNotificationCategory.setActions([toGoogleMapsAction, cancelUpcomingStopAction], forContext: UIUserNotificationActionContext.Default)
        routeNotificationCategory.setActions([toGoogleMapsAction, cancelUpcomingStopAction], forContext: UIUserNotificationActionContext.Minimal)
        
        // Request permission to send notifications and register settings
        let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound | UIUserNotificationType.Badge, categories: Set(arrayLiteral: routeNotificationCategory))
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        let address = notification.userInfo?["address"] as! NSString
        if identifier == "routeTo" {
            NSNotificationCenter.defaultCenter().postNotificationName("routeToPressed", object: nil, userInfo: ["address": address])
        } else if identifier == "cancelStop" {
            NSNotificationCenter.defaultCenter().postNotificationName("cancelStopPressed", object: nil)
        }
        completionHandler()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

