//
//  DocumentDataModeling.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
protocol DocumentDataModeling {
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DocumentViewModelList
    
    
    //TODO: Get url implementation
    func getUrl(data: NSDictionary) -> String
}

extension DocumentDataModeling{
    func prepareDataSourceForId(type_name:String,idproof_no:String) -> DocumentViewModelList{
        return DocumentViewModelList([DocumentDataModel]())
    }
}
