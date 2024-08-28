//
//  ServiceDetailVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
class ServiceDetailVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = ServiceDetailVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.Service_LT, placeholder: ConstantTexts.SelectService_PH, value: ConstantTexts.empty, type: SignUpType.Gender),
                          DataStoreStruct(title: ConstantTexts.PriceLT, placeholder: ConstantTexts.EmailPricePH, value: ConstantTexts.empty, type: SignUpType.ACNumber)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    //TODO: Prepare data source implementation
    func prepareDataSourceWith(info: ServiceDataViewModel) -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.Service_LT, placeholder: ConstantTexts.SelectService_PH, value: info.service_name, type: SignUpType.Gender),
                          DataStoreStruct(title: ConstantTexts.PriceLT, placeholder: ConstantTexts.EmailPricePH, value: info.price, type: SignUpType.ACNumber)]
        
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type {
           
            case .Gender:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.SelectService_ALERT, false, index, Int())
                    return
                    
                }
                
                
                
            case .ACNumber:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterPriceALERT, false, index, Int())
                    return
                    
                }
                
               
                
            default:
                break
            }
        }
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
}
