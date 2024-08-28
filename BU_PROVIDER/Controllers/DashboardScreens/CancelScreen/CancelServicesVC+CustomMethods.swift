//
//  CancelServicesVC+CustomMethods.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 24/08/21.
//

import Foundation
extension CancelServicesVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.CancelledServices_LT, AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)

    }

    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }

        /*
        if self.serviceModeling == nil{
            self.serviceModeling = SelectMyServicesVM.shared
        }

         */


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
        self.tblService.register(nib: BookingTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
        self.hitGetCanceledServices()
    }
}


//MARK: - Extension web services
extension CancelServicesVC{
    internal func hitGetCanceledServices(){
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }

        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }

         let parameters = [Api_keys_model.provider_id:user.id] as [String:AnyObject]
        // let parameters = [Api_keys_model.provider_id:"61"] as [String:AnyObject]
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.providerCancelList, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? [String:Any]{
                print(result_Dict)
                if let code = result_Dict["status"] as? Int{
                    if code == 200{
                        self.cancelServiceVM = CancelService(fromDictionary: result_Dict)
                            DispatchQueue.main.async {
                                self.tblService.reloadData()
                            }
                    }else{
                        if let message = result_Dict["message"] as? String{
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

