//
//  LoginVM.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
class LoginVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = LoginVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.PhoneNumberTitle, placeholder: ConstantTexts.PhoneNumberPH, value: ConstantTexts.empty, type: SignUpType.PhoneNumber)]
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type {
            case .PhoneNumber:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterMobileNumberALERT, false, index, Int())
                    return
                    
                }
                else if !validationMethodManager!.isValidIndianPhoneCount(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidMobileNumberALERT, false, index, Int())
                    return
                }
            default:
                break
            }
        }
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
}
