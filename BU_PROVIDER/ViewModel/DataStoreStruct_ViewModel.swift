//
//  DataStoreStruct_ViewModel.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit


//TODO: Parent view model for showing list of dataStoreStruct
struct DataStoreStruct_List_ViewModel {
    var dataStoreStructs:[DataStoreStruct]
    
}

extension DataStoreStruct_List_ViewModel{
    init(_ dataStoreStructs:[DataStoreStruct]) {
        self.dataStoreStructs = dataStoreStructs
    }
}

extension DataStoreStruct_List_ViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.dataStoreStructs.count
    }
    
    
    public func dataStoreStructAtIndex(_ index:Int) -> DataStoreStruct_ViewModel{
        return DataStoreStruct_ViewModel(self.dataStoreStructs[index])
    }
    
}





//TODO: Child view model for showing a single category
struct DataStoreStruct_ViewModel {
     var dataStoreStruct:DataStoreStruct
}

extension DataStoreStruct_ViewModel{
    init(_ dataStoreStruct:DataStoreStruct) {
        self.dataStoreStruct = dataStoreStruct
    }
}


extension DataStoreStruct_ViewModel{
    
   var title:String{
        return self.dataStoreStruct.title
    }
    
    var placeholder:String{
        return self.dataStoreStruct.placeholder
    }
    
    var value:String{
        return self.dataStoreStruct.value
    }
    
    var type:SignUpType{
        return self.dataStoreStruct.type!
    }
    
  /*  var image:UIImage{
        return self.dataStoreStruct.image
    } */
    
}
