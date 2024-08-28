//
//  AddAddreessVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
class AddAddreessVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = AddAddreessVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.SelectAddressTypeTitle, placeholder: ConstantTexts.SelectAddress_PH, value: ConstantTexts.empty, type: SignUpType.SelectAddressType),
                          DataStoreStruct(title: ConstantTexts.AddressTitle, placeholder: ConstantTexts.AddressPH, value: ConstantTexts.empty, type: SignUpType.Address),
                          DataStoreStruct(title: ConstantTexts.AreaTitle, placeholder: ConstantTexts.Area_PH, value: ConstantTexts.empty, type: SignUpType.Area),
                          DataStoreStruct(title: ConstantTexts.StateTitle, placeholder: ConstantTexts.State_PH, value: ConstantTexts.empty, type: SignUpType.State),
                          
                          DataStoreStruct(title: ConstantTexts.CityTitle, placeholder: ConstantTexts.City_PH, value: ConstantTexts.empty, type: SignUpType.City),
                          
                          DataStoreStruct(title: ConstantTexts.ZipCodeTitle, placeholder: ConstantTexts.ZipCode_PH, value: ConstantTexts.empty, type: SignUpType.ZipCode)]
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSourceNew(item:AddressDataModel) -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.SelectAddressTypeTitle, placeholder: ConstantTexts.SelectAddress_PH, value: item.address_type, type: SignUpType.SelectAddressType),
                          DataStoreStruct(title: ConstantTexts.AddressTitle, placeholder: ConstantTexts.AddressPH, value: item.house_no, type: SignUpType.Address),
                          DataStoreStruct(title: ConstantTexts.AreaTitle, placeholder: ConstantTexts.Area_PH, value: item.locality, type: SignUpType.Area),
                          DataStoreStruct(title: ConstantTexts.StateTitle, placeholder: ConstantTexts.State_PH, value: item.statename, type: SignUpType.State),
                          
                          DataStoreStruct(title: ConstantTexts.CityTitle, placeholder: ConstantTexts.City_PH, value: ConstantTexts.empty, type: SignUpType.City),
                          
                          DataStoreStruct(title: ConstantTexts.ZipCodeTitle, placeholder: ConstantTexts.ZipCode_PH, value: item.pincode, type: SignUpType.ZipCode)]
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type {
            
            case .SelectAddressType:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.SelectAddrssTypeALERT, false, index, Int())
                    return
                }
                
               
            case .Address:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterAddrssTypeALERT, false, index, Int())
                    return
                }
                
            case .Area:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterAreaALERT, false, index, Int())
                    return
                }
                
                
            case .State:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.SelectStateALERT, false, index, Int())
                    return
                }
                
                
            case .City:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index - 1).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.SelectStateFirstALERT, false, index, Int())
                    return
                }
                
               else if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.SelectCityALERT, false, index, Int())
                    return
                }
                
            
            case .ZipCode:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterValidALERT, false, index, Int())
                    return
                    
                }
                else if !validationMethodManager!.isValidZipCode(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidZipCodeALERT, false, index, Int())
                    return
                }
            default:
                break
            }
        }
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
}

extension AddAddreessVM:StateCityDepnendencyInjection{
    func prepareDataSourceState(with array: NSArray) -> (StateCityListViewModel, [String]) {
        var states:[String] = [ConstantTexts.State_PH]
        var stateItems:[StateCityDataModel] = [StateCityDataModel(id: ConstantTexts.empty, name: ConstantTexts.State_PH, state_id: String())]
        for item in array{
            if let itemDict = item as? NSDictionary{
                var state:StateCityDataModel = StateCityDataModel(id: String(), name: String(), state_id: String())
                if let id = itemDict.value(forKey: "id") as? String{
                    state.id = id
                }
                
                if let id = itemDict.value(forKey: "id") as? Int{
                    state.id = "\(id)"
                }
                
                
                if let name = itemDict.value(forKey: "name") as? String{
                    state.name = name
                    states.append(name)
                }
                stateItems.append(state)
            }
        }
        
       return (StateCityListViewModel(items: stateItems), states)
    }
    
    func prepareDataSourceCity(with array: NSArray) -> (StateCityListViewModel, [String]) {
        
        var cities:[String] = [ConstantTexts.City_PH]
        var cityItems:[StateCityDataModel] = [StateCityDataModel(id: ConstantTexts.empty, name: ConstantTexts.City_PH, state_id: String())]
        
        for item in array{
            if let itemDict = item as? NSDictionary{
                var city:StateCityDataModel = StateCityDataModel(id: String(), name: String(), state_id: String())
                if let id = itemDict.value(forKey: "id") as? String{
                    city.id = id
                }
                
                if let id = itemDict.value(forKey: "id") as? Int{
                    city.id = "\(id)"
                }
                
                if let state_id = itemDict.value(forKey: "state_id") as? String{
                    city.state_id = state_id
                    
                    
                }
                
                
                if let state_id = itemDict.value(forKey: "state_id") as? Int{
                    city.id = "\(state_id)"
                }
                
                
                if let name = itemDict.value(forKey: "city") as? String{
                    city.name = name
                    cities.append(name)
                }
                cityItems.append(city)
            }
        }
        
        return (StateCityListViewModel(items: cityItems), cities)
    }
    
    
}
