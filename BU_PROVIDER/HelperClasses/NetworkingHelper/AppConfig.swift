//
//  AppConfig.swift
//  Lawyer
//
//  Created by Aman Kumar on 16/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import XCGLogger

class SAppConfig: NSObject {
    
    static let _log = XCGLogger.default
    static let defautQ = DispatchQueue.global(qos: .default)
    static let defautMainQ = DispatchQueue.main
    static let backgrountQ = DispatchQueue.global(qos: .background)
    static let priorityQ = DispatchQueue.global(qos: .userInteractive)
    static var debugDate = Date()
    
    /**
     Fully qualified host name including port
     **/
    static func getServiceHostURL() -> String {
        let bundle = Bundle.main.object(forInfoDictionaryKey:"App Server Url")
        return bundle as! String
    }
    
    
    static func getGoogleClientID() -> String {
        let bundle = Bundle.main.object(forInfoDictionaryKey:"Google Client Id")
        return bundle as! String
    }
    
    static func getAppName() -> String {
        let bundle = Bundle.main.object(forInfoDictionaryKey:"App Name")
        return bundle as! String
    }
    
    
}

