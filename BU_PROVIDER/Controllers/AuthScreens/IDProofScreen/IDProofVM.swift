//
//  IDProofVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
import UIKit
class IDProofVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = IDProofVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.SelectIDProofTitle, placeholder: ConstantTexts.SelectIDProofTitle, value: ConstantTexts.empty, type: SignUpType.IDProof),
                          DataStoreStruct(title: ConstantTexts.NameIDProofTitle, placeholder: ConstantTexts.NamePH, value: ConstantTexts.empty, type: SignUpType.NameID),
                          DataStoreStruct(title: ConstantTexts.IDNumberTitle, placeholder: ConstantTexts.IDNumberPH, value: ConstantTexts.empty, type: SignUpType.IDNumber)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSourceForId(type_name:String,idproof_no:String) -> DataStoreStruct_List_ViewModel{
        let dataStores = [DataStoreStruct(title: ConstantTexts.SelectIDProofTitle, placeholder: ConstantTexts.SelectIDProofTitle, value: type_name, type: SignUpType.IDProof),
                          DataStoreStruct(title: ConstantTexts.NameIDProofTitle, placeholder: ConstantTexts.NamePH, value: ConstantTexts.empty, type: SignUpType.NameID),
                          DataStoreStruct(title: ConstantTexts.IDNumberTitle, placeholder: ConstantTexts.IDNumberPH, value: idproof_no, type: SignUpType.IDNumber)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
  
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type {
            case .IDProof:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.SelectIDProofALERT, false, index, Int())
                    return
                    
                }
                
            case .NameID:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterNameALERT, false, index, Int())
                    return
                    
                }
                
                
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidNameALERT, false, index, Int())
                    return
                    
                }
                
                
            case .IDNumber:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterIDNumberALERT, false, index, Int())
                    return
                    
                }
                
                
            default:
                break
            }
        }
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
}
