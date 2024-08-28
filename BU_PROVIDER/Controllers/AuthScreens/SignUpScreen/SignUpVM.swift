//
//  SignUpVM.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
class SignUpVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = SignUpVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.FullNameTitle, placeholder: ConstantTexts.FullNamePH, value: ConstantTexts.empty, type: SignUpType.FullName),
                         
                          DataStoreStruct(title: ConstantTexts.EmailAddressTitle, placeholder: ConstantTexts.EmailAddressPH, value: ConstantTexts.empty, type: SignUpType.Email),
                          
                          DataStoreStruct(title: ConstantTexts.PhoneNumberTitle, placeholder: ConstantTexts.PhoneNumberPH, value: ConstantTexts.empty, type: SignUpType.PhoneNumber),
                          
                          DataStoreStruct(title: ConstantTexts.PasswordTitle, placeholder: ConstantTexts.PasswordPH, value: ConstantTexts.empty, type: SignUpType.Password)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type {
            
            case .FullName:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterFullNameALERT, false, index, Int())
                    return
                    
                }
                    
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidFullNameALERT, false, index, Int())
                    return
                    
                }
                
                
            case .Email:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterEmailALERT, false, index, Int())
                    return
                }
                else if !validationMethodManager!.isValidEmail(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidEmailALERT, false, index, Int())
                    return
                }
                
                
            case .PhoneNumber:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterMobileNumberALERT, false, index, Int())
                    return
                    
                }
                else if !validationMethodManager!.isValidIndianPhoneCount(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidMobileNumberALERT, false, index, Int())
                    return
                }
                
                
            case .Password:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterPasswordALERT, false, index, Int())
                    return
                    
                }
                
                else if !validationMethodManager!.isValidPasswordCount(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidPasswordALERT, false, index, Int())
                    return
                }
            
            default:
                break
                
            }
        }
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
}
