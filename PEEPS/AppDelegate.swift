//
//  AppDelegate.swift
//  PEEPS
//
//  Created by Murali Dadi on 7/24/18.
//  Copyright © 2018 Murali Dadi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn
import FacebookLogin
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var loginManager = LoginManager()

    
    func fblogout(){
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
        loginManager.logOut()
        
        
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        loginManager.loginBehavior  = .web
        let navBar = UINavigationBar.appearance()
//        navBar.barTintColor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.0)
//        navBar.tintColor = UIColor(red: 254.00/255.0, green: 167.00/255.0, blue: 37.00/255.0, alpha: 1.0)
        navBar.isTranslucent = false
        navBar.setBackgroundImage(UIImage(named:"header_gadient.png"), for: .any, barMetrics: .default)
        
        
        navBar.titleTextAttributes = [kCTForegroundColorAttributeName:UIColor(red: 255/255.0, green: 255/255.0, blue: 255.00/255.0, alpha: 1.0)] as [NSAttributedStringKey : Any]
        
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        navBar.titleTextAttributes = attrs
        
        
        GIDSignIn.sharedInstance().clientID = "366139261999-srj87fahttfuf1pgeumthstv87evlfjl.apps.googleusercontent.com"
      
        
         FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions:launchOptions)
        IQKeyboardManager.shared.enable = true
        
        return true
       
    }
    func opengoogleimages(name:String) {
        
        if let url = URL(string: "https://www.google.com/search?tbm=isch&q="+name) {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    func switchBack() {
        
        // switch back to view controller 1
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "one")
        
        self.window?.rootViewController = nav
    }
    func showNetworkAlert(viewc:UIViewController,titles:String,messages:String){
        
        let alert = UIAlertController(title: titles, message:messages, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        viewc.present(alert, animated: true, completion: nil)
        
        
    }
    private func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
        
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url as URL?,
                                                                   sourceApplication: sourceApplication,
                                                                   annotation: annotation)
        
        let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url as URL?,
            sourceApplication: sourceApplication,
            annotation: annotation)
        
        return googleDidHandle || facebookDidHandle
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       
//        let isFacebookURL = url.scheme != nil && url.scheme!.hasPrefix("fb\(FBSDKSettings.appID())") && url.host == "authorize"
//        if isFacebookURL {
//            return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL?, sourceApplication: sourceApplication, annotation: annotation)
//        }
//        return false
    }
   func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url as URL?,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
//    func application(application: UIApplication,
//                     openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
//        var options: [String: AnyObject] = [UIApplicationOpenURLOptionsSourceApplicationKey: sourceApplication,
//                                            UIApplicationOpenURLOptionsAnnotationKey: annotation]
//        return GIDSignIn.sharedInstance().handleURL(url,
//                                                    sourceApplication: sourceApplication,
//                                                    annotation: annotation)
//    }
    func applicationDidBecomeActive(application: UIApplication) {
        //App activation code
        FBSDKAppEvents.activateApp()
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

