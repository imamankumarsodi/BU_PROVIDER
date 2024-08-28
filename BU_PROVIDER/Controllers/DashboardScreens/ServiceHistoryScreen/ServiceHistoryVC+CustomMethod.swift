//
//  ServiceHistoryVC+CustomMethod.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
import SkeletonView
extension ServiceHistoryVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false," \(ConstantTexts.ServiceHistory_LT)", AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        
     
        super.isHiddenNavigationBar(false)
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.serviceModeling == nil{
            self.serviceModeling = ServiceHistoryVM.shared
        }
        
    
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        
        
        self.registerNib()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.tblEarnings.hideEmptyCells()
      //  self.tblEarnings.addSubview(self.refreshControl)
        self.tblEarnings.register(nib: ServiceHistoryTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
        self.hitgetServiceHistory()
        self.tblEarnings.reloadData()
    }
}


//MARK: - Extension web services
extension ServiceHistoryVC{
    //MARK: - Web services
    //TODO: State list Service
    
    //TODO: Show sekeleton animation
    internal func showAnimation(){
        DispatchQueue.main.async {
            self.tblEarnings.showAnimatedSkeleton()
            
            self.btnUpcomingRef.showAnimatedSkeleton()
            self.btnPastRef.showAnimatedSkeleton()
            self.header.lblUserName.showAnimatedSkeleton()
            self.header.lblServiceName.showAnimatedSkeleton()
            self.header.lblDateTime.showAnimatedSkeleton()
            self.header.lblPrice.showAnimatedSkeleton()
         
            
        }
    }
    
    //TODO: Show all fields
    internal func hideAnimation(){
        DispatchQueue.main.async {
            self.btnUpcomingRef.hideSkeleton()
            self.btnPastRef.hideSkeleton()
            
            self.tblEarnings.hideSkeleton()
            self.header.lblUserName.hideSkeleton()
            self.header.lblServiceName.hideSkeleton()
            self.header.lblDateTime.hideSkeleton()
            self.header.lblPrice.hideSkeleton()
            
            
        }
        
        
    }
    
    
    
    internal func hitgetServiceHistory(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
       let parameters = [Api_keys_model.provider_id:user.id] as [String:AnyObject]
        
        self.showAnimation()
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.servicehistory, method: .post, parameters: parameters, header: nil, success: { (result) in
            self.hideAnimation()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                        if let response = result_Dict.value(forKey: "response") as? NSArray{
                            if self.services == nil{
                                self.services = self.serviceModeling?.prepareDataSource(response)
                            }else{
                                self.services = self.serviceModeling?.prepareDataSource(response)
                            }
                            DispatchQueue.main.async {
                                self.tblEarnings.reloadData()
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
    
    
    
    
}

