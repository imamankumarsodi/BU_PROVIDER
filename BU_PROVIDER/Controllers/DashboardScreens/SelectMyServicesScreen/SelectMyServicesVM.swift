//
//  SelectMyServicesVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
class SelectMyServicesVM: ServiceListModeling {
    
    //TODO: Singleton object
    static let shared = SelectMyServicesVM()
    private init() {}
    
    func prepareDataSource(_ array: NSArray) -> ServiceDataListModel {
    
        var services:[ServiceDataModel] = [ServiceDataModel]()
        
        for item in array{
            if let itemDict = item as? NSDictionary{
                var service:ServiceDataModel = ServiceDataModel(fixed: String(), id: String(), provider_id: String(), price: String(), service_id: String(), service_model: String(), service_name: String(), service_number: String(), service_type_id: String(), status: String())
                if let fixed = itemDict.value(forKey: "fixed") as? String{
                    service.fixed = fixed
                }
                
                if let fixed = itemDict.value(forKey: "fixed") as? Int{
                    service.fixed = "\(fixed)"
                }
                
                if let id = itemDict.value(forKey: "id") as? String{
                    service.id = id
                }
                
                if let id = itemDict.value(forKey: "id") as? Int{
                    service.id = "\(id)"
                }
                
                if let price = itemDict.value(forKey: "price") as? String{
                    service.price = price
                }
                
                if let price = itemDict.value(forKey: "price") as? Int{
                    service.price = "\(price)"
                }
                
                if let provider_id = itemDict.value(forKey: "provider_id") as? String{
                    service.provider_id = provider_id
                }
                
                if let provider_id = itemDict.value(forKey: "provider_id") as? Int{
                    service.provider_id = "\(provider_id)"
                }
                
                if let service_id = itemDict.value(forKey: "service_id") as? String{
                    service.service_id = service_id
                }
                
                if let service_id = itemDict.value(forKey: "service_id") as? Int{
                    service.service_id = "\(service_id)"
                }
                
                if let service_model = itemDict.value(forKey: "service_model") as? String{
                    service.service_model = service_model
                }
                
                if let service_model = itemDict.value(forKey: "service_model") as? Int{
                    service.service_model = "\(service_model)"
                }
                
                
                if let service_name = itemDict.value(forKey: "service_name") as? String{
                    service.service_name = service_name
                }
                
                
                if let service_number = itemDict.value(forKey: "service_number") as? String{
                    service.service_number = service_number
                }
                
                if let service_number = itemDict.value(forKey: "service_number") as? Int{
                    service.service_number = "\(service_number)"
                }
                
                
                if let service_type_id = itemDict.value(forKey: "service_type_id") as? String{
                    service.service_type_id = service_type_id
                }
                
                if let service_type_id = itemDict.value(forKey: "service_type_id") as? Int{
                    service.service_type_id = "\(service_type_id)"
                }
                
                if let status = itemDict.value(forKey: "status") as? String{
                    service.status = status
                }
                
                services.append(service)
                
            }
        }
        
        return ServiceDataListModel(services)
        
        
    }
    
    
}
