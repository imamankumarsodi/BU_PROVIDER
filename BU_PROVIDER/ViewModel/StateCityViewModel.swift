//
//  StateCityViewModel.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
//TODO: Parent view model for showing list of category
struct StateCityListViewModel {
    var items:[StateCityDataModel]
}



extension StateCityListViewModel{
    public func itemAtIndex(_ index:Int) -> StateCityViewModel{
        return StateCityViewModel(self.items[index])
    }
}




//TODO: Child view model for showing a single category
struct StateCityViewModel {
    private let item:StateCityDataModel
}

extension StateCityViewModel{
    init(_ item:StateCityDataModel) {
        self.item = item
    }
}

extension StateCityViewModel{
  
    var id:String{
        return self.item.id
    }
    
    
    var name:String{
        return self.item.name
    }

}
