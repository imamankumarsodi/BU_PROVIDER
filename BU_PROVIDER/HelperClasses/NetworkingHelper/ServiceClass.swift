//
//  ServiceClass.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import Reachability
import Alamofire


final class ServiceClass: SBaseService {
    //TODO: Singleton object
    static let shared = ServiceClass()
    private override init() {}
    
    public func webServiceBasicMethod(url:String, method:HTTPMethod, parameters:[String:Any]?, header:HTTPHeaders? = nil, success: @escaping (Any)-> (), failure: @escaping (Error)->()) -> Void {
        print(url)
        print(parameters as Any)
        
        
        if !NetworkState.isConnected() {
            failure(NSError(domain: ConstantTexts.Network_Error, code: 1009, userInfo: [ConstantTexts.errorMessage_Key : ConstantTexts.noInterNet]))
            return
        }
        
        
        guard let urlValue = URL(string: SBaseService().getServiceHostURL() + url) else{
            failure(NSError(domain: ConstantTexts.URL_Error, code: 400, userInfo: [ConstantTexts.errorMessage_Key : ConstantTexts.Invalid_URL]))
            return
        }
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 300
        
        print(urlValue)
        
        manager.request(urlValue, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: header).validate().responseJSON { response in
            
            switch (response.result){
            case .success(let value):
                success(value)
                
            case .failure(let error):
                failure(error)
            }
            
        }
        
        
    }
    
    func multipartImageServiceWithArrayObject(url:String, _ data:[DocumentDataModel], header:[String:String]? = nil, parameters:[String:Any]?, success: @escaping (Any)-> (), failure: @escaping (Error)->()) -> Void {
        
        if !NetworkState.isConnected() {
            failure(NSError(domain: ConstantTexts.Network_Error, code: 1009, userInfo: [ConstantTexts.errorMessage_Key : ConstantTexts.noInterNet]))
            return
        }
        
        guard let urlValue = URL(string: SBaseService().getServiceHostURL() + url) else{
            failure(NSError(domain: ConstantTexts.URL_Error, code: 400, userInfo: [ConstantTexts.errorMessage_Key : ConstantTexts.Invalid_URL]))
            return
        }
        
        print(urlValue)
        print(header)
        print(parameters)
        print(data.count)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 300
        
        manager.upload(multipartFormData: { (multipartFormData) in
            for (_,item) in data.enumerated() {
                if item.mimeType == "document"{
                    if let stringURL = URL(string: item.fileName){
                        let filename = stringURL.lastPathComponent
                        let splitName = filename.split(separator: ".")
                        let value = splitName.last ?? ""
                        let mime = "application/" + value
                        multipartFormData.append(item.data as Data, withName:item.withName,fileName: item.fileName, mimeType:mime)
                    }
                }else{
                    print(item.mimeType)
                    multipartFormData.append(item.data as Data, withName: item.withName, fileName: item.fileName, mimeType: item.mimeType)
                }
            }
            
            
            guard let param = parameters else {
                return
            }
            for (key,value) in param {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            
        }, to: urlValue,headers: header){
            (result) in
            print(result)
            switch result {
            case .success(let upload, _,_ ):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })
                upload.responseData { response in
                    
                    upload.responseJSON {
                        (response) -> Void in
                        print(response)
                        switch(response.result){
                        case .success(let value):
                            print(value)
                            if let dict = value as? [String:Any]{
                                success(dict)
                            }
                            else{
                                if let dict = value as? [String:Any]{
                                    
                                    if let code = dict["code"] as? Int{
                                        if let message = dict["message"] as? String{
                                            failure(NSError(domain: ConstantTexts.SW_Error,code:code,userInfo: ["errorMessage":message]))
                                        }
                                    }
                                }
                            }
                        case .failure(let error):
                            failure(error)
                        }
                    }
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
}
