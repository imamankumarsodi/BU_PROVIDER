//
//  DeclarationVC+CustomMethods.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
extension DeclarationVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false," \(ConstantTexts.declaration_LT)", AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)
    }
    
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        self.hitDecleraionContent()
        
       
    }

}



//MARK: - Extension web services
 extension DeclarationVC{
    //MARK: - Web services
    //TODO: State list Service
    internal func hitDecleraionContent(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.declarationContent, method: .get, parameters: nil, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                print(result_Dict)
                if let content = result_Dict.value(forKey: "content") as? String{
                    self.txtView.text = content
                }
               /* if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        
                       
                        
                    }else{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                    }
                } */
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
    
    
    internal func hitDecleraionCheck(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        let parameters = [Api_keys_model.provider_id:user.id,
                          Api_keys_model.address_provider_id:user.id,
                          Api_keys_model.declaration:"Y"] as [String:AnyObject]
        
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.declarationCheck, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                        
                        self.customMethodManager?.updateStatus(id: user.id, status: "declaration")
                        self.callBackDec?()
                        self.navigationController?.popViewController(animated: true)
                        
                        
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
    
    
    
    
    
    
    
    
    
  /*  func updateAdderss(id:String,user:UserDataModel){
        
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
    } */
    

    
}
