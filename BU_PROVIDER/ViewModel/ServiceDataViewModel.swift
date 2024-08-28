//
//  ServiceDataViewModel.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation


//TODO: Parent view model for showing list of DocumentDataModel
struct ServiceDataListModel {
    var services:[ServiceDataModel]
}

extension ServiceDataListModel{
    init(_ services:[ServiceDataModel]) {
        self.services = services
    }
}


extension ServiceDataListModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.services.count
    }
    
    
    public func serviceAtIndex(_ index:Int) -> ServiceDataViewModel{
        return ServiceDataViewModel(self.services[index])
    }
    
}



//TODO: Child view model for showing a single DocumentDataModel
struct ServiceDataViewModel {
    var service:ServiceDataModel
}

extension ServiceDataViewModel{
    init(_ service:ServiceDataModel) {
        self.service = service
    }
}

extension ServiceDataViewModel{
    var fixed:String{
        return self.service.fixed
    }
    
    var id:String{
        return self.service.id
    }
    
    
    var price:String{
        return self.service.price
    }
    
    var provider_id:String{
        return self.service.provider_id
    }
    
    
    var service_id:String{
        return self.service.service_id
    }
    
    var service_model:String{
        return self.service.service_model
    }
    
    
    var service_name:String{
        return self.service.service_name
    }
    
    var service_number:String{
        return self.service.service_number
    }
    
    var service_type_id:String{
        return self.service.service_type_id
    }
    
    var status:String{
        return self.service.status
    }
    
   
    
   
}
