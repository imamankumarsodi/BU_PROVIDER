//
//  SceneDelegate+CustomMethods.swift
//  BU
//
//  Created by Aman Kumar on 26/01/21.
//

import Foundation
import IQKeyboardManagerSwift
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseAnalytics
import FirebaseCrashlytics
import UserNotifications
import GoogleSignIn

extension SceneDelegate{
    
    //TODO: Initial setup implementation
    internal func initialSetup(){
        
        self.setupIQKeyboard()
        self.registerForRemoteNotification()
        self.registerForFCMToken()
    }
    
    
    //TODO: Initial IQKeyboardManager setup implementation
    private func setupIQKeyboard(){
        /// Implementation IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    }
    
}

//MARK: - Extension for get Device token
extension SceneDelegate:UNUserNotificationCenterDelegate{
    
    //TODO: Todo get device token
    private func registerForRemoteNotification() {
        
        let simulaterToken = ConstantTexts.simulateToken
        USER_DEFAULTS.set(simulaterToken as String, forKey: ConstantTexts.deviceToken)
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if error == nil{
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }else{
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        // USER_DEFAULTS.set(deviceTokenString as String, forKey: ConstantTexts.deviceToken)
        NSLog("Device Token : %@", deviceTokenString)
        
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        let simulaterToken = ConstantTexts.simulateToken
        
        // USER_DEFAULTS.set(simulaterToken, forKey: ConstantTexts.deviceToken)
        print(error, terminator: "")
    }
    
}


//MARK: - Extension for get FCM TOKEN
extension SceneDelegate:MessagingDelegate{
    
    //TODO: Todo get firebase token
    private func registerForFCMToken(){
        /// Firebase implementation
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = SAppConfig.getGoogleClientID()
        GIDSignIn.sharedInstance().delegate = self
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        Crashlytics.crashlytics().checkForUnsentReports { _ in
            Crashlytics.crashlytics().sendUnsentReports()
        }
        
        /// Messaging delegate implementation
        Messaging.messaging().delegate = self
        
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        if let getFCMToken = fcmToken{
            USER_DEFAULTS.set(getFCMToken, forKey: ConstantTexts.deviceToken)
        }
    }
    
}




