//
//  EarningsVC+CustomMethods.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
import SkeletonView
extension EarningsVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false," \(ConstantTexts.Earning_LT)", AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        
     
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
        
        
  
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.TotalEarning_LT)\n", font: AppFont.Bold.size(AppFontName.Montserrat, size: 16), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CurLT) 0", font: AppFont.Medium.size(AppFontName.Montserrat, size: 30), color: AppColor.app_pass_color) ?? NSMutableAttributedString())
        
        
    
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblEarnings.attributedText = myMutableString
        
        
        
        
        self.registerNib()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.tblEarnings.hideEmptyCells()
        self.tblEarnings.register(nib: IDProofTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
        
        self.hitgetServiceHistory()
        self.tblEarnings.reloadData()
    }
}

//MARK: - Extension web services
extension EarningsVC{
    //MARK: - Web services
    //TODO: State list Service
    
    //TODO: Show sekeleton animation
    internal func showAnimation(){
        DispatchQueue.main.async {
            self.tblEarnings.showAnimatedSkeleton()
            
            self.lblEarnings.showAnimatedSkeleton()
            self.header.lblUserName.showAnimatedSkeleton()
            self.header.lblServiceName.showAnimatedSkeleton()
            self.header.lblDateTime.showAnimatedSkeleton()
            self.header.lblPrice.showAnimatedSkeleton()
         
            
        }
    }
    
    //TODO: Show all fields
    internal func hideAnimation(){
        DispatchQueue.main.async {
            self.lblEarnings.hideSkeleton()
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
                        if let response = result_Dict.value(forKey: "response") as? NSDictionary{
                            
                            // *** Create instance of `NSMutableParagraphStyle`
                            let paragraphStyle = NSMutableParagraphStyle()
                            paragraphStyle.alignment = .left
                            // *** set LineSpacing property in points ***
                            paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
                            
                            let myMutableString = NSMutableAttributedString()
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.TotalEarning_LT)\n", font: AppFont.Bold.size(AppFontName.Montserrat, size: 16), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
                            
                            if let earn = response.value(forKey: "earning") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CurLT) \(earn)", font: AppFont.Medium.size(AppFontName.Montserrat, size: 30), color: AppColor.app_pass_color) ?? NSMutableAttributedString())
                            }else{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CurLT) 0", font: AppFont.Medium.size(AppFontName.Montserrat, size: 30), color: AppColor.app_pass_color) ?? NSMutableAttributedString())
                            }
                            
                            
                        
                            // *** Apply attribute to string ***
                            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                            // *** Set Attributed String to your label ***
                            self.lblEarnings.attributedText = myMutableString
                            
                            
                            
                            if let servicesArray = response.value(forKey: "services") as? NSArray{
                                if self.services == nil{
                                    self.services = self.serviceModeling?.prepareDataSource(servicesArray)
                                }else{
                                    self.services = self.serviceModeling?.prepareDataSource(servicesArray)
                                }
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

