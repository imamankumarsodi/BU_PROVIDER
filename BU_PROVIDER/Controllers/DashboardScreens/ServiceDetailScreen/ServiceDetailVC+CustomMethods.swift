//
//  ServiceDetailVC+CustomMethods.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
import SkeletonView
extension ServiceDetailVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        if isComingFromEdit{
            self.footer.btnEditRef.setTitle(ConstantTexts.EditLT, for: .normal)
            super.setupNavigationBarTitle(AppColor.header_color,false," \(ConstantTexts.editServicesTitle)", AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        }else{
            self.footer.btnEditRef.setTitle(ConstantTexts.AddLT, for: .normal)
            super.setupNavigationBarTitle(AppColor.header_color,false," \(ConstantTexts.AddServicesTitle)", AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        }
        
        
        super.isHiddenNavigationBar(false)
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.otpModel == nil {
            self.otpModel = ServiceDetailVM.shared
        }
        
        if self.isComingFromEdit{
            if let infoT = self.info{
                
                self.id = infoT.id
                self.selectedId = infoT.service_id
                if infoT.status == "online"{
                    self.selectedTag = "online"
                    self.footer.btnOnlineRef.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                    self.footer.btnOflineRef.setImage(UIImage(systemName: "square"), for: .normal)
                }else{
                    self.selectedTag = "offline"
                    self.footer.btnOnlineRef.setImage(UIImage(systemName: "square"), for: .normal)
                    self.footer.btnOflineRef.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                }
                
                if  self.dataListVM == nil{
                    self.dataListVM = self.otpModel?.prepareDataSourceWith(info: infoT)
                }
                
                
                
            }
        }else{
            if  self.dataListVM == nil{
                self.dataListVM = self.otpModel?.prepareDataSource()
            }
        }
        
        
        
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.footer.btnEditRef.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)
        
        self.footer.btnOnlineRef.tag = 0
        self.footer.btnOflineRef.tag = 1
        self.footer.btnOnlineRef.addTarget(self, action: #selector(btnSelectOnlineOflineTapped), for: .touchUpInside)
        self.footer.btnOflineRef.addTarget(self, action: #selector(btnSelectOnlineOflineTapped), for: .touchUpInside)
        
        
        self.registerNib()
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.tblPersonalInfo.hideEmptyCells()
        self.tblPersonalInfo.register(nib: IDProofTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
        self.hitgetStates()
        self.tblPersonalInfo.reloadData()
    }
    
    
    //TODO: setup validation
    internal func isValidate(){
        super.dismissKeyboard()
        if let dataListVM_T = self.dataListVM{
            self.otpModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    
                    if self.selectedTag == ""{
                        self.customMethodManager?.showAlert(ConstantTexts.SelectStatusALERT, okButtonTitle: ConstantTexts.OkBT, target: self)
                    }else{
                        if self.isComingFromEdit{
                            self.hitAddService(service_name: "service-update")
                        }else{
                            self.hitAddService(service_name: "service-create")
                        }
                    }
                    
                    //  self.hitUpDateProfile()
                    
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    if let cell = self.tblPersonalInfo.cellForRow(at: indexPath) as? IDProofTableViewCell{
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        if row != 0{
                            cell.textFieldFloating.becomeFirstResponder()
                        }
                    }
                }
            })
        }
    }
    
    
}


//MARK: - Extension web services
extension ServiceDetailVC{
    //MARK: - Web services
    //TODO: State list Service
    
    //TODO: Show sekeleton animation
    internal func showAnimation(){
        DispatchQueue.main.async {
            self.tblPersonalInfo.showAnimatedSkeleton()
            self.footer.lblStatus.showAnimatedSkeleton()
            self.footer.btnOnlineRef.showAnimatedSkeleton()
            self.footer.btnOflineRef.showAnimatedSkeleton()
            
            self.footer.btnEditRef.showAnimatedSkeleton()
            self.footer.btnViewRef.showAnimatedSkeleton()
            
        }
    }
    
    //TODO: Show all fields
    internal func hideAnimation(){
        DispatchQueue.main.async {
            
            self.tblPersonalInfo.hideSkeleton()
            self.footer.lblStatus.hideSkeleton()
            self.footer.btnOnlineRef.hideSkeleton()
            self.footer.btnOflineRef.hideSkeleton()
            
            self.footer.btnEditRef.hideSkeleton()
            self.footer.btnViewRef.hideSkeleton()
            
            
        }
        
        
    }
    
    
    
    internal func hitgetStates(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        self.showAnimation()
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.servicesService, method: .post, parameters: nil, header: nil, success: { (result) in
            self.hideAnimation()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                        /* if let array = result_Dict.value(forKey: "response") as? NSArray{
                         
                         if let stateItems = self.stateCityDataModelVM?.prepareDataSourceState(with: array).0{
                         self.addressStateListVM = stateItems
                         }
                         
                         if let stateItemStrings = self.stateCityDataModelVM?.prepareDataSourceState(with: array).1{
                         self.states = stateItemStrings
                         }
                         } */
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
    
    
    //MARK: - Web services
    //TODO: Signup Service
    internal func hitAddService(service_name:String){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
       
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
       
        guard let dataListVM_T = self.dataListVM else{
            print("No dataListVM_T found...")
            return
        }
        
        

        
        var parameters:[String:AnyObject] = [String:AnyObject]()
        
        if service_name == "service-create"{
            parameters = [Api_keys_model.provider_id:user.id,
                          Api_keys_model.service_id:self.selectedId,
                          Api_keys_model.status:self.selectedTag,
                          Api_keys_model.fixed:dataListVM_T.dataStoreStructAtIndex(1).value] as [String:AnyObject]
        }else{
            parameters = [Api_keys_model.provider_id:user.id,
                          Api_keys_model.service_id:self.selectedId,
                          Api_keys_model.status:self.selectedTag,
                          Api_keys_model.fixed:dataListVM_T.dataStoreStructAtIndex(1).value,
                          Api_keys_model.id:self.id] as [String:AnyObject]
        }
     
            
      
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: "\(SAuthApi.addCreateUpdate)\(service_name)", method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                       
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
    
    
}
