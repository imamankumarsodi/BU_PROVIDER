//
//  AppMacros.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit

let NOTIFICATION_CENTER = NotificationCenter.default
let FILE_MANAGER = FileManager.default
let MAIN_BUNDLE = Bundle.main
let MAIN_THREAD = Thread.main
let MAIN_SCREEN = UIScreen.main
let MAIN_SCREEN_WIDTH = UIScreen.main.bounds.width
let MAIN_SCREEN_HEIGHT = UIScreen.main.bounds.height
let USER_DEFAULTS = UserDefaults.standard
let APPLICATION = UIApplication.shared
let CURRENT_DEVICE = UIDevice.current
let MAIN_RUN_LOOP = RunLoop.main
let GENERAL_PASTEBOARD = UIPasteboard.general
let CURRENT_LANGUAGE = NSLocale.current.languageCode
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
var newProfile = Bool()
let STATUS_BAR_DEFAULT_HEIGHT = 20
let NAVIGATION_BAR_DEFAULT_HEIGHT = 44
let NAVIGATION_BAR_BUTTON_DEFAULT_WIDTH = 40.0
let EDGE_INSET = CGFloat(10.0)
let TOOLBAR_DEFAULT_HEIGHT = 44
let TABBAR_DEFAULT_HEIGHT = 49
let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
let KEY_WINDOW = UIApplication.shared.keyWindow
let APP_DELEGATE = (APPLICATION.delegate) as! AppDelegate
// Application informations
let APP_VERSION = MAIN_BUNDLE.object(forInfoDictionaryKey: "CFBundleVersion")
let IN_SIMULATOR = (TARGET_IPHONE_SIMULATOR != 0)
let NOTIFICATION_RESPONSE_MODEL = "NOTIFICATION_RESPONSE_MODEL"


//TODO: Network
let kNoInterNet = "No internet"

//TODO: Application informations

let APP_BUNDLE_NAME = MAIN_BUNDLE.infoDictionary?[kCFBundleNameKey as String]
let APP_NAME = SAppConfig.getAppName()
let APP_LINK = "https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example"
let IS_NEW_CODE = false


var SCREEN_NAME:String =  String()
