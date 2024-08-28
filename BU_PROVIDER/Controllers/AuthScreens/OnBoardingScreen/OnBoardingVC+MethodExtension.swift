//
//  OnBoardingVC+MethodExtension.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 31/03/21.
//

import Foundation
import UIKit
extension OnBoardingVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.OnBoardingTitle, AppColor.whiteColor, leftBarButtonsType: [.empty], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.onboardingVM == nil {
            self.onboardingVM = OnBoardingVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.onboardingVM?.prepareDataSourceStatic()
        }
        self.initialSetup()
    }
    
    
    //TODO: IntialSetup
    private func initialSetup(){
        
        
        guard let userData = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(userData.first_name) \(userData.last_name)\n", font: AppFont.Bold.size(AppFontName.Montserrat, size: 18), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(userData.email)\n", font: AppFont.Medium.size(AppFontName.Montserrat, size: 16), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(userData.mobile)", font: AppFont.Medium.size(AppFontName.Montserrat, size: 16), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.header.lblDetials.attributedText = myMutableString
        
        self.footer.btnContinueRef.addTarget(self, action: #selector(btnbtnContinueTapped), for: .touchUpInside)
        
        
        
      
        
        print(userData.status)
        
        switch userData.status{
       
        case "idproof" :
            self.dataListVM?.onboardingDataList[0].status = true
        case "personaldetails" :
            self.dataListVM?.onboardingDataList[0].status = true
            self.dataListVM?.onboardingDataList[1].status = true
       
        case "address" :
            self.dataListVM?.onboardingDataList[0].status = true
            self.dataListVM?.onboardingDataList[1].status = true
            self.dataListVM?.onboardingDataList[2].status = true
        case "declaration" :
            self.dataListVM?.onboardingDataList[0].status = true
            self.dataListVM?.onboardingDataList[1].status = true
            self.dataListVM?.onboardingDataList[2].status = true
            self.dataListVM?.onboardingDataList[3].status = true
           
        default:
           print("Do nothing")

            
        }
        
        
        self.registerNib()
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.obTableView.register(nib: OnboardingTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
        
        DispatchQueue.main.async {
            self.obTableView.reloadData()
        }
    }
    

}
