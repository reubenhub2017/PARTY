//
//  AppDelegate.swift
//  PARTY
//
//  Created by Reuben Ukah on 6/28/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
import Bolts
import UIKit
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
   
    
    
    var window: UIWindow?

        

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        Appirater.appLaunched(true)
        
        
        
        if let launchOptions = launchOptions as? [String : AnyObject] {
            if let notificationDictionary = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] as? [NSObject : AnyObject] {
                self.application(application, didFinishLaunchingWithOptions: notificationDictionary)
            }
        }
        
        // Initialize Parse.
        Parse.setApplicationId("uZyMLPRGXCm96mhQPknOuSzZsqUJSr8kNUc0bHCQ",
            clientKey: "DXmN3pnjumCCECMCbSG3hwfz3fJ85PKzn44YGqEG")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // ...
        
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.backItem?.backBarButtonItem?.title = ""
        
        let barAppearace = UIBarButtonItem.appearance()
        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics:UIBarMetrics.Default)


        
        navigationBarAppearace.barTintColor = UIColor(red: 0.6, green: 0.1, blue: 0.1, alpha: 1)
        navigationBarAppearace.tintColor = UIColor.whiteColor()
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
   
        
        
        
//        
//        let pageControl = UIPageControl.appearance()
//        
//        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
//        
//        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
//        
//        pageControl.backgroundColor = UIColor.whiteColor()
        
        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
       
        if let font = UIFont(name: "Avenir-Black ", size: 18) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font,  NSForegroundColorAttributeName: UIColor.whiteColor()]
          
         
        }
     
        
        return true
        
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation["user"] = PFUser.currentUser()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
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

