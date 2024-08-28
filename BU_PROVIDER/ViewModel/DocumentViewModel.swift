//
//  DocumentViewModel.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit

//TODO: Parent view model for showing list of DocumentDataModel
struct DocumentViewModelList {
    var documentDataItems:[DocumentDataModel]
}

extension DocumentViewModelList{
    init(_ documentDataItems:[DocumentDataModel]) {
        self.documentDataItems = documentDataItems
    }
}


extension DocumentViewModelList{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.documentDataItems.count
    }
    
    
    public func documentAtIndex(_ index:Int) -> DocumentViewModel{
        return DocumentViewModel(self.documentDataItems[index])
    }
    
}




//TODO: Child view model for showing a single DocumentDataModel
struct DocumentViewModel {
    var documentDataModel:DocumentDataModel
}

extension DocumentViewModel{
    init(_ documentDataModel:DocumentDataModel) {
        self.documentDataModel = documentDataModel
    }
}

extension DocumentViewModel{
    var data:Data{
        return self.documentDataModel.data
    }
    
    var type:String{
        return self.documentDataModel.type
    }
    
    var withName:String{
        return self.documentDataModel.withName
    }
    
    var fileName:String{
        return self.documentDataModel.fileName
    }
    
    var mimeType:String{
        return self.documentDataModel.mimeType
    }
    
   
}
