//
//  AppDelegate.swift
//  Cookies
//
//  Created by Omar Allaham on 1/26/17.
//  Copyright © 2017 Bemaxnet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?


   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.

      loadHTTPCookies()

      return true
   }

   func applicationWillResignActive(_ application: UIApplication) {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(_ application: UIApplication) {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

      saveCookies()
   }

   func applicationWillEnterForeground(_ application: UIApplication) {
      // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

      loadHTTPCookies()
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(_ application: UIApplication) {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

      saveCookies()
   }


}

extension AppDelegate {
   func loadHTTPCookies() {

      if let cookieDict = UserDefaults.standard.value(forKey: "cookieArray") as? NSMutableArray {

         for c in cookieDict {

            let cookies = UserDefaults.standard.value(forKey: c as!String) as!NSDictionary
            let cookie = HTTPCookie(properties: cookies as![HTTPCookiePropertyKey: Any])

            HTTPCookieStorage.shared.setCookie(cookie!)
         }
      }
   }

   func saveCookies() {

      let cookieArray = NSMutableArray()
      if let savedC = HTTPCookieStorage.shared.cookies {
         for c: HTTPCookie in savedC {

            let cookieProps = NSMutableDictionary()
            cookieArray.add(c.name)
            cookieProps.setValue(c.name, forKey: HTTPCookiePropertyKey.name.rawValue)
            cookieProps.setValue(c.value, forKey: HTTPCookiePropertyKey.value.rawValue)
            cookieProps.setValue(c.domain, forKey: HTTPCookiePropertyKey.domain.rawValue)
            cookieProps.setValue(c.path, forKey: HTTPCookiePropertyKey.path.rawValue)
            cookieProps.setValue(c.version, forKey: HTTPCookiePropertyKey.version.rawValue)
            cookieProps.setValue(NSDate().addingTimeInterval(2629743), forKey: HTTPCookiePropertyKey.expires.rawValue)

            UserDefaults.standard.setValue(cookieProps, forKey: c.name)
            UserDefaults.standard.synchronize()
         }
      }
      
      UserDefaults.standard.setValue(cookieArray, forKey: "cookieArray")
   }
}

