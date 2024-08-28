//
//  BaseViewController+DocumentPicker.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit
import MobileCoreServices

extension BaseViewController:UIDocumentPickerDelegate{
    
    
    //TODO: Open documents
    public func openDocuments(){
        let documentsPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData)], in: .import)
        documentsPicker.delegate = self
        documentsPicker.allowsMultipleSelection = false
        self.present(documentsPicker, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: - Document picker delegates
    //TODO: Implementation documentPicker
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            do
            {
                var item = DocumentDataModel(data: Data(), type: ".pdf", withName:Api_keys_model.Idproof_picture, fileName: String(), mimeType: "document")
                item.fileName = "\(myURL)"
                item.data = try Data.init(contentsOf: URL.init(string:"\(item.fileName)")!)
                DispatchQueue.main.async {
                    self.getDocCallBack?(item)
                }
            }
            catch {
                // error
            }
        }
    }
    
    //TODO: Implementation documentPickerWasCancelled
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
}
