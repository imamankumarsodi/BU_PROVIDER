//
//  PersonalDetailsVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
import UIKit

class PersonalDetailsVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    internal var customMethodManager:CustomMethodProtocol?
    //TODO: Singleton object
    static let shared = PersonalDetailsVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.SOWOTitle, placeholder: ConstantTexts.SOWOTitle, value: ConstantTexts.empty, type: SignUpType.SOWO),
                          DataStoreStruct(title: ConstantTexts.GenderTitle, placeholder: ConstantTexts.GenderTitle, value: ConstantTexts.empty, type: SignUpType.Gender),
                          DataStoreStruct(title: ConstantTexts.DOBTitle, placeholder: ConstantTexts.DOBTitle, value: ConstantTexts.empty, type: SignUpType.DOB)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    //TODO: Prepare data source implementation
    func prepareDataSourceLocal() -> DataStoreStruct_List_ViewModel{
        
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            fatalError("No user found...")
        }
        
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.FirstNameTitle, placeholder: ConstantTexts.FirstNamePH, value: user.first_name, type: SignUpType.FirstName),
                          DataStoreStruct(title: ConstantTexts.LastNameTitle, placeholder: ConstantTexts.LastNamePH, value: user.last_name, type: SignUpType.FirstName),
                          DataStoreStruct(title: ConstantTexts.PhoneNumberTitle, placeholder: ConstantTexts.PhoneNumberPH, value: user.mobile, type: SignUpType.PhoneNumber)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type {
           
                
            case .SOWO:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterNameALERT, false, index, Int())
                    return
                    
                }
                
                
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterParent_ALERT, false, index, Int())
                    return
                    
                }
                
                
            case .FirstName:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterFirstNameALERT, false, index, Int())
                    return
                    
                }
                
                
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidFirstNameALERT, false, index, Int())
                    return
                    
                }
                
                
            case .LastName:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterLastNameALERT, false, index, Int())
                    return
                    
                }
                
                
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidLastNameALERT, false, index, Int())
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

                
                
            case .Gender:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.SelectGender_ALERT, false, index, Int())
                    return
                    
                }
                
                
                
                
                
                
            case .DOB:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.SelectDob_ALERT, false, index, Int())
                    return
                    
                }
                
                
            default:
                break
            }
        }
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
}
