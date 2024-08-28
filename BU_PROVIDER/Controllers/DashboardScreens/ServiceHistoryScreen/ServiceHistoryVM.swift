//
//  ServiceHistoryVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
class ServiceHistoryVM: ServiceHistoryModeling {
    
    //TODO: Singleton object
    static let shared = ServiceHistoryVM()
    private init() {}
    
    func prepareDataSource(_ array: NSArray) -> ServiceHistoryListModel {
    
        var services:[ServiceHistoryDataModel] = [ServiceHistoryDataModel]()
        
        for item in array{
            if let itemDict = item as? NSDictionary{
                var service:ServiceHistoryDataModel = ServiceHistoryDataModel(id: String(), service_number: String(), user_id: String(), first_name: String(), last_name: String(), service_id: String(), provider_id: String(), address_id: String(), contact_number: String(), service_date: String(), additional_note: String(), amount: String(), status: String(), address: String(), service_name: String())
                
                if let id = itemDict.value(forKey: "id") as? String{
                    service.id = id
                }
                
                if let id = itemDict.value(forKey: "id") as? Int{
                    service.id = "\(id)"
                }
                
                
                
                if let service_number = itemDict.value(forKey: "service_number") as? String{
                    service.service_number = service_number
                }
                
                
                
                if let user_id = itemDict.value(forKey: "user_id") as? String{
                    service.user_id = user_id
                }
                
                if let user_id = itemDict.value(forKey: "user_id") as? Int{
                    service.user_id = "\(user_id)"
                }
                
                
                
                
                if let first_name = itemDict.value(forKey: "first_name") as? String{
                    service.first_name = first_name
                }
                
                if let last_name = itemDict.value(forKey: "last_name") as? String{
                    service.last_name = last_name
                }
                
                
                if let service_id = itemDict.value(forKey: "service_id") as? String{
                    service.service_id = service_id
                }
                
                if let service_id = itemDict.value(forKey: "service_id") as? Int{
                    service.service_id = "\(service_id)"
                
                }
                
                
                if let provider_id = itemDict.value(forKey: "provider_id") as? String{
                    service.provider_id = provider_id
                }
                
                if let provider_id = itemDict.value(forKey: "provider_id") as? Int{
                    service.provider_id = "\(provider_id)"
                }
                
                if let address_id = itemDict.value(forKey: "address_id") as? String{
                    service.address_id = address_id
                }
                
                if let address_id = itemDict.value(forKey: "address_id") as? Int{
                    service.address_id = "\(address_id)"
                }
                
                if let contact_number = itemDict.value(forKey: "contact_number") as? String{
                    service.contact_number = contact_number
                }
                
                if let contact_number = itemDict.value(forKey: "contact_number") as? Int{
                    service.contact_number = "\(contact_number)"
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
                
                
                if let service_date = itemDict.value(forKey: "service_date") as? String{
                    service.service_date = service_date
                }
                
                
                if let additional_note = itemDict.value(forKey: "additional_note") as? String{
                    service.additional_note = additional_note
                }
                
                
                if let amount = itemDict.value(forKey: "amount") as? String{
                    service.amount = amount
                }
                
                if let amount = itemDict.value(forKey: "amount") as? Int{
                    service.amount = "\(amount)"
                }
                
                
                if let status = itemDict.value(forKey: "status") as? String{
                    service.status = status
                }
                
                if let status = itemDict.value(forKey: "status") as? Int{
                    service.status = "\(status)"
                }
                
                if let address = itemDict.value(forKey: "address") as? String{
                    service.address = address
                }
                
                
                if let service_name = itemDict.value(forKey: "service_name") as? String{
                    service.service_name = service_name
                }
                
                
                services.append(service)
                
            }
        }
        
        return ServiceHistoryListModel(services)
        
        
    }
    
    
}
