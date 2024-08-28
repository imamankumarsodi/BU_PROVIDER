//
//  ServiceHistoryViewDataModel.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation


//TODO: Parent view model for showing list of DocumentDataModel
struct ServiceHistoryListModel {
    var services:[ServiceHistoryDataModel]
}

extension ServiceHistoryListModel{
    init(_ services:[ServiceHistoryDataModel]) {
        self.services = services
    }
}


extension ServiceHistoryListModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.services.count
    }
    
    
    public func serviceAtIndex(_ index:Int) -> ServiceHistoryViewDataModel{
        return ServiceHistoryViewDataModel(self.services[index])
    }
    
}





//TODO: Child view model for showing a single DocumentDataModel
struct ServiceHistoryViewDataModel {
    var service:ServiceHistoryDataModel
}

extension ServiceHistoryViewDataModel{
    init(_ service:ServiceHistoryDataModel) {
        self.service = service
    }
}

extension ServiceHistoryViewDataModel{
   
    var id:String{
        return self.service.id
    }
    
    var service_number:String{
        return self.service.service_number
    }
    
    
    var user_id:String{
        return self.service.user_id
    }
    
    var first_name:String{
        return self.service.first_name
    }
    
    var last_name:String{
        return self.service.last_name
    }
    
    
    var provider_id:String{
        return self.service.provider_id
    }
    
    
    var service_id:String{
        return self.service.service_id
    }
    
    var address_id:String{
        return self.service.address_id
    }
    
    
    var contact_number:String{
        return self.service.contact_number
    }
    
    var service_date:String{
        return self.service.service_date
    }
    
    var additional_note:String{
        return self.service.additional_note
    }
    
    var amount:String{
        return self.service.amount
    }
    
    var status:String{
        return self.service.status
    }
    
    var address:String{
        return self.service.address
    }
    
    var service_name:String{
        return self.service.service_name
    }
   
}
