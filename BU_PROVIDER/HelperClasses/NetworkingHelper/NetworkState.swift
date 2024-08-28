//
//  NetworkState.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import Alamofire
class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
