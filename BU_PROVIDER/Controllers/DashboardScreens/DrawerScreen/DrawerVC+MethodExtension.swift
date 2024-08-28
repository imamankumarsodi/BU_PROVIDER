//
//  DrawerVC+MethodExtension.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/03/21.
//

import Foundation
extension DrawerVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = false
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.MoreTitle, AppColor.whiteColor, leftBarButtonsType: [.empty], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.settingsVM == nil {
            self.settingsVM = DrawerVM.shared
        }
        
        if  self.categoryListVM == nil{
            self.categoryListVM = self.settingsVM?.prepareDataSourceStatic()
        }
        self.initialSetup()
    }
    
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.registerNib()
        self.tblSettings.hideEmptyCells()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.tblSettings.register(nib: SettingsTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
    }
}



//MARK: - Extension web services
extension DrawerVC{
    
    //MARK: - Web services
    //TODO: Signup Service
    internal func hitLogOutService(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        let parameters = [Api_keys_model.id:user.id] as [String:AnyObject]
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.logout, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let message = result_Dict.value(forKey: "message") as? String{
                    if message == "Logged out Successfully"{
                        print(result_Dict)
                        self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                            super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                        })
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
}
