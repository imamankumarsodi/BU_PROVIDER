//
//  AddAddreessVC+CustomMethods.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
import UIKit
import SkeletonView
import CoreData
extension AddAddreessVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false," \(ConstantTexts.AddressTitle)", AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.addressDataModel == nil {
            self.addressDataModel = AddAddreessVM.shared
        }
        
        if self.addressDataListVM == nil{
            self.addressDataListVM = self.addressDataModel?.prepareDataSource()
        }
        
        if self.isComingForEditing{
            if isComingForEditing{
                guard let user = customMethodManager?.getUser(entity: "User_Data") else{
                    print("No user found...")
                    return
                }
                self.addressDataListVM?.dataStoreStructs[0].value = user.address_type
                self.addressDataListVM?.dataStoreStructs[1].value = user.house_no
                self.addressDataListVM?.dataStoreStructs[2].value = user.locality
                
                
                self.addressDataListVM?.dataStoreStructs[3].value = user.statename
                self.addressDataListVM?.dataStoreStructs[4].value = user.cityname
                self.addressDataListVM?.dataStoreStructs[5].value = user.pincode
            }
        }
        
        if self.stateCityDataModelVM == nil{
            self.stateCityDataModelVM = AddAddreessVM.shared
        }

        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.footer.lblSignUpRef.isHidden = true
        self.footer.btnContinueRef.addTarget(self, action: #selector(btnbtnContinueTapped), for: .touchUpInside)
        self.registerNib()
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.manageTable.register(nib: IDProofTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }

        self.manageTable.reloadData()
        self.hitgetStates()
    }
    
    //TODO: Show sekeleton animation
    internal func showAnimation(){
        DispatchQueue.main.async {
            self.manageTable.showAnimatedSkeleton()
            self.footer.btnContinueRef.showAnimatedSkeleton()
        }
    }
    
    //TODO: Show all fields
    internal func hideAnimation(){
        DispatchQueue.main.async {

            self.manageTable.hideSkeleton()
            self.footer.btnContinueRef.hideSkeleton()
            
        }
        
        
    }

    
    
    //TODO: setup validation
   internal func isValidate(){
        super.dismissKeyboard()
        if let dataListVM_T = self.addressDataListVM{
            self.addressDataModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                self.hitAddAddressService()
                    
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    self.manageTable.scrollToRow(at: indexPath,
                                                   at: .top,
                                                   animated: true)
                    if let cell = self.manageTable.cellForRow(at: indexPath) as? IDProofTableViewCell{
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        if row != 0 || row != 3 || row != 4{
                            cell.textFieldFloating.becomeFirstResponder()
                        }
                        
                    }
                }
            })
        }
    }
    

    
    
}


//MARK: - Extension web services
 extension AddAddreessVC{
    //MARK: - Web services
    //TODO: State list Service
    internal func hitgetStates(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        self.showAnimation()
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.user_state, method: .post, parameters: nil, header: nil, success: { (result) in
            self.hideAnimation()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                        if let array = result_Dict.value(forKey: "response") as? NSArray{
                            
                            if let stateItems = self.stateCityDataModelVM?.prepareDataSourceState(with: array).0{
                                self.addressStateListVM = stateItems
                            }
                            
                            if let stateItemStrings = self.stateCityDataModelVM?.prepareDataSourceState(with: array).1{
                                self.states = stateItemStrings
                            }
                        }
                    }else{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                    }
                }
            }
            
        }) {(error) in
            self.hideAnimation()
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }
        }
    }
    
    
    //TODO: State list Service
    internal func hitgetCities(id:String){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        let parameters = [Api_keys_model.state_id:id] as [String:AnyObject]
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.user_city, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                        if let array = result_Dict.value(forKey: "response") as? NSArray{
                            
                            if let cityItems = self.stateCityDataModelVM?.prepareDataSourceCity(with: array).0{
                                self.addressCityListVM = cityItems
                            }
                            
                            if let cityItemStrings = self.stateCityDataModelVM?.prepareDataSourceCity(with: array).1{
                                self.cities = cityItemStrings
                            }
                        }
                    }else{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                    }
                }
            }
            
        }) {(error) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }
        }
    }
    
    
    
    
    
    
    //TODO: Hit user address service
    internal func hitAddAddressService(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        
        var user_saved = UserDataModel(access_token: String(), device_id: String(), device_token: String(), device_type: String(), email: String(), first_name: String(), full_name: String(), id: String(), last_name: String(), latitude: String(), longitude: String(), picture: String(), rating: String(), rating_count: String(), social_unique_id: String(), mobile: String(), stripe_cust_id: String(), wallet_balance: String(), login_by: String(), status: String(),dob:String(), gender:String(), parent_name:String(),address_type:String(),house_no:String(),locality:String(),statename:String(),cityname:String(),pincode:String())
        
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        user_saved = user
        
        
        let address_type = self.addressDataListVM?.dataStoreStructAtIndex(0).value == ConstantTexts.HomeLT ? "1" : "2"
    
        let parameters = [Api_keys_model.address_provider_id:user.id,
                          Api_keys_model.address_type:address_type,
                          Api_keys_model.address:self.addressDataListVM?.dataStoreStructAtIndex(1).value,
                          Api_keys_model.locality:self.addressDataListVM?.dataStoreStructAtIndex(2).value,
                          Api_keys_model.state_id:self.state_id,
                          Api_keys_model.city_id:self.city_id,
                          Api_keys_model.zipcode:self.addressDataListVM?.dataStoreStructAtIndex(5).value,
                          Api_keys_model.pincode:self.addressDataListVM?.dataStoreStructAtIndex(5).value,
                          Api_keys_model.Pincode:self.addressDataListVM?.dataStoreStructAtIndex(5).value] as [String:AnyObject]
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.addUpdateaddress, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    
                    print(result_Dict)
                    
                    if code == 200{
                        
                        self.customMethodManager?.updateStatus(id: user.id, status: "address")
                        
                        user_saved.address_type = self.addressDataListVM?.dataStoreStructAtIndex(0).value ?? String()
                        
                        user_saved.house_no = self.addressDataListVM?.dataStoreStructAtIndex(1).value ?? String()
                        
                        user_saved.locality = self.addressDataListVM?.dataStoreStructAtIndex(2).value ?? String()
                        
                        user_saved.statename = self.addressDataListVM?.dataStoreStructAtIndex(3).value ?? String()
                        
                        user_saved.cityname = self.addressDataListVM?.dataStoreStructAtIndex(4).value ?? String()
                        
                        user_saved.pincode = self.addressDataListVM?.dataStoreStructAtIndex(5).value ?? String()
                        
                        
                        self.updateAdderss(id: user.id, user: user_saved)
                        self.callBackAddress?()
                        self.navigationController?.popViewController(animated: true)
                            
                    }else{
                        
                      
                       if let message = result_Dict.value(forKey: "message") as? String{
                        self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }

                    }
                }
            }
            
        }) { (error) in
            print(error)
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }
        }
    }
    
    
    func updateAdderss(id:String,user:UserDataModel){
        
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User_Data")
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let result = try context.fetch(request)
            if result.count > 0{
                let filterObject = result.first as! NSManagedObject
                filterObject.setValue(user.address_type, forKey: "address_type")
                filterObject.setValue(user.house_no, forKey: "house_no")
                filterObject.setValue(user.locality, forKey: "locality")
                
                
                filterObject.setValue(user.statename, forKey: "statename")
                filterObject.setValue(user.cityname, forKey: "cityname")
                filterObject.setValue(user.pincode, forKey: "pincode")

                
                do{
                    try context.save()
                }catch{
                    print("Failed")
                }
            }
        } catch {
            print("Failed")
        }
    }
    

    
}
