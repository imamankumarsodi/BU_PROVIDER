//
//  SelectMyServicesVC+CustomMethods.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
extension SelectMyServicesVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.SelectServicesTitle, AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.add])
        super.isHiddenNavigationBar(false)
        
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.serviceModeling == nil{
            self.serviceModeling = SelectMyServicesVM.shared
        }
        self.initialSetup()
    }
    
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.tblService.hideEmptyCells()
        self.registerNib()
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.tblService.addSubview(self.refreshControl)
        self.tblService.register(nib: ServiceTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
            
            
            
            
        }
    }
    
    
    
    
}

//MARK: - Extension web services
extension SelectMyServicesVC{
    
    internal func hitGetProviderServices(){
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        let parameters = [Api_keys_model.provider_id:user.id] as [String:AnyObject]
        
        // let parameters = [Api_keys_model.provider_id:"71"] as [String:AnyObject]

        
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.provider_service, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                print(result_Dict)
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        
                        if let response = result_Dict.value(forKey: "response") as? NSArray{
                            if self.services == nil{
                                self.services = self.serviceModeling?.prepareDataSource(response)
                            }else{
                                self.services = self.serviceModeling?.prepareDataSource(response)
                            }
                            DispatchQueue.main.async {
                                self.tblService.reloadData()
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
}
