//
//  SplashVC+MethodExtension.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
extension SplashVC{
    
    //TODO: Initial setup
    internal func initialSetup(){
        
        
        
        
        for family in UIFont.familyNames {
            let sName: String = family as String
            print("family: \(sName)")
            
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
        
        
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        
        self.runAnimationLogo()
    }
    
    //TODO: Run logo animation
    private func runAnimationLogo(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut], animations: {
            self.logo_splash.alpha = 0
            self.logo_splash.transform = CGAffineTransform(scaleX: 3, y: 3)
            
        }) { (done) in
            if done{
                
               if let isEmpty = self.customMethodManager?.entityIsEmpty(entity: "User_Data"){
                    if isEmpty{
                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                    }else{
                        
                        guard let userData = self.customMethodManager?.getUser(entity: "User_Data") else{
                            print("No user found...")
                            return
                        }
                        
                        if userData.status == "underreview" || userData.status == "approved" {
                            let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
                            UIApplication.shared.windows.first?.rootViewController = vc
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }else{
                            super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: OnBoardingVC.className)
                        }
                        
                    }
                }else{
                    super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                }
            }
        }
    }
}
