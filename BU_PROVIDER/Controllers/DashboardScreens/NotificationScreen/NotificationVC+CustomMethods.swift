//
//  NotificationVC+CustomMethods.swift
//  BU
//
//  Created by Aman Kumar on 09/02/21.
//

import Foundation
import UIKit
extension NotificationVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.NotificationTitle, AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        self.initialSetup()
        
    }
    
    
    
    private func initialSetup(){
        self.registerNib()
    }
    

    //TODO: register nib file
    private func registerNib(){
        self.tblNotification.register(nib: NotificationCellAndXib.className)
       // self.tblNotification.addSubview(self.refreshControl)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
    }
    
}
