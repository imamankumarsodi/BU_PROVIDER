//
//  SBaseService.swift
//  Lawyer
//
//  Created by Aman Kumar on 16/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import Alamofire
import XCGLogger

class SBaseService {
    let _log = SAppConfig._log
    
 /*   func reqHeader() -> HTTPHeaders {
        
        let parameters:HTTPHeaders = [
            "Authorization":"Basic YWRtaW5AZGVsaXZlcnktZmFjdG9yeS5jb206UGFzc0B3b3JkMQ==",]
        return parameters
    }
    
    func reqHeaderWithToken() -> HTTPHeaders {
        
        if let authToken = USER_DEFAULTS.value(forKey: ConstantTexts.authToken) as? String{
            let parameters:HTTPHeaders = [
                "Authorization":"Basic YWRtaW5AZGVsaXZlcnktZmFjdG9yeS5jb206UGFzc0B3b3JkMQ==",
                "authToken": authToken]
            return parameters
        }
        else{
            return reqHeader()
        }
    }
    
    func reqHeaderWithType()->[String:String]{
        let parameters:[String:String] = ["Content-Type": "application/json",
                                          "accept": "application/json"]
        return parameters
    }
    
    
    func testqHeaderWithToken() -> HTTPHeaders {
            let parameters:HTTPHeaders = [
                "Authorization":"Basic YWRtaW5AZGVsaXZlcnktZmFjdG9yeS5jb206UGFzc0B3b3JkMQ==",
                "authToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjMDUwMDNjOTYyNWQxM2RmZjUyYjdmMSIsImlhdCI6MTU0MzgzMTYxMiwiZXhwIjozMDY3MzU4NDM2fQ.miruvllUCtloWX-Yd6I8jIGBaXdDGcp9XeKh-j-6nZE"
            ];
            return parameters
    } */
    
    func getServiceHostURL() -> String {
        return SAppConfig.getServiceHostURL()
    }
}

