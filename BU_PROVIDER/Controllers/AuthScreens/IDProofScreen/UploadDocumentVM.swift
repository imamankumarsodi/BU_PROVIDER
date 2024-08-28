//
//  UploadDocumentVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
class UploadDocumentVM: DocumentDataModeling {
    
    static let shared = UploadDocumentVM()
    private init() {}
    
    func prepareDataSource() -> DocumentViewModelList {
        let docDataArray = [DocumentDataModel]()
        return DocumentViewModelList(documentDataItems: docDataArray)
    }
    
    func getUrl(data: NSDictionary) -> String {
        var docr:String = String()
        if let doc = data.value(forKey: "doc") as? String{
            docr = doc
        }
       return docr
    }
  
}
