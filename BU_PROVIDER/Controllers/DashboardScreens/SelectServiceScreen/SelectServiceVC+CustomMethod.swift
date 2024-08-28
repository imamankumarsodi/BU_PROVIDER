//
//  SelectServiceVC+CustomMethod.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit
extension SelectServiceVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.empty, AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)
        
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.settingsVM == nil {
            self.settingsVM = SelectServiceVM.shared
        }
        
        if  self.categoryListVM == nil{
            self.categoryListVM = self.settingsVM?.prepareDataSourceStatic()
        }
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
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.SelectYourLT)\n", font: AppFont.Medium.size(AppFontName.Montserrat, size: 14), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.PrimaryBLT)", font: AppFont.Bold.size(AppFontName.Montserrat, size: 18), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblTitle.attributedText = myMutableString
        
        
        self.search_bar.searchTextField.backgroundColor = AppColor.whiteColor
        self.tblSettings.hideEmptyCells()
        self.registerNib()
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.tblSettings.register(nib: CategoriesTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
    }

}
