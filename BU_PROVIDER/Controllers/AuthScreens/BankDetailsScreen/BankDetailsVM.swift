//
//  BankDetailsVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit
class BankDetailsVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = BankDetailsVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.BeneficiaryNameTitle, placeholder: ConstantTexts.BeneficiaryNameTitle, value: ConstantTexts.empty, type: SignUpType.NameID),
                          DataStoreStruct(title: ConstantTexts.AccountNumberTitle, placeholder: ConstantTexts.AccountNumberTitle, value: ConstantTexts.empty, type: SignUpType.ACNumber),
                          DataStoreStruct(title: ConstantTexts.IFSCCodeTitle, placeholder: ConstantTexts.IFSCCodeTitle, value: ConstantTexts.empty, type: SignUpType.IFSC)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type {
            
                
            case .NameID:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterBeneficiaryNameALERT, false, index, Int())
                    return
                    
                }
                
                
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidBeneNameALERT, false, index, Int())
                    return
                    
                }
                
                
            case .ACNumber:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterAcountNumberALERT, false, index, Int())
                    return
                    
                }
                
                
                
            case .IFSC:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterIFSCALERT, false, index, Int())
                    return
                    
                }
                
                
            default:
                break
            }
        }
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
}
