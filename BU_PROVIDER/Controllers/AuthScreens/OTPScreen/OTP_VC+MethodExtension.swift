//
//  OTP_VC+MethodExtension.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
import FirebaseAuth
extension OTP_VC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.VarificationTitle, AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [])
        super.isHiddenNavigationBar(false)
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.otpModel == nil {
            self.otpModel = OTP_VM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.otpModel?.prepareDataSource()
        }
        print(authVerificationID)
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.header.lblHeaderTitle.text = ConstantTexts.OTP_VerificationLT
        
        
        self.footer.lblSignUpRef.text = ConstantTexts.ResendOTPLT
        let lblSignIn_Tap = UITapGestureRecognizer(target: self, action: #selector(self.lblSignInRefTapped(_:)))
        self.footer.lblSignUpRef.isUserInteractionEnabled = true
        self.footer.lblSignUpRef.addGestureRecognizer(lblSignIn_Tap)
        
        self.footer.btnContinueRef.addTarget(self, action: #selector(btnbtnContinueTapped), for: .touchUpInside)
        self.footer.btnContinueRef.setTitle(ConstantTexts.GetStarted_BT, for: .normal)
        
        
        registerNib()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.otpTable.register(nib: Auth_TextField_TableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
    }
    
    
    //TODO: setup validation
    internal func isValidate(){
        super.dismissKeyboard()
        if let dataListVM_T = self.dataListVM{
            self.otpModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    self.checkFireBaseOTP()
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    if let cell = self.otpTable.cellForRow(at: indexPath) as? Auth_TextField_TableViewCell{
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        cell.textFieldFloating.becomeFirstResponder()
                    }
                }
            })
        }
    }
    
    
    //TODO: Get first name and last name
    private func getFirstNameAndLastName(from fullName: String)->(String,String){
        var components = fullName.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
            return(firstName,lastName)
        }else{
            return(fullName,ConstantTexts.empty)
        }
    }
    
}


//MARK: - Extension web services
extension OTP_VC{
    
    //TODO: Login Service
    private func hitLoginService(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let dataListVM_T = self.userDataVM else{
            print("No dataListVM_T found...")
            return
        }
        
        guard let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String else {
            print("No FirebaseId found...")
            return
        }
        
        
        let parameters = [Api_keys_model.social_unique_id:ConstantTexts.empty,
                          Api_keys_model.device_type:ConstantTexts.deviceTypeNew,
                          Api_keys_model.device_token:FirebaseId,
                          Api_keys_model.device_id: FirebaseId,
                          Api_keys_model.mobile:"\(ConstantTexts.CountryCode_LT)\(dataListVM_T.dataStoreStructAtIndex(0).value)"] as [String:AnyObject]
        
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.login, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                        if let responseArray = result_Dict.value(forKey: "response") as? NSArray{
                            
                            for item in responseArray{
                                if let responseDict = item as? NSDictionary{
                                    print(responseDict)
                                    if let userData = self.customMethodManager?.getUserModelFromApi(responseDict: responseDict){
                                        self.customMethodManager?.saveDataToLocal_DB(userData: userData, callBack: {
                                            if userData.status == "underreview" || userData.status == "approved" {
                                                let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
                                                UIApplication.shared.windows.first?.rootViewController = vc
                                                UIApplication.shared.windows.first?.makeKeyAndVisible()
                                            }else{
                                                super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: OnBoardingVC.className)
                                            }

                                        })
                                    }
                                    
                                }
                            }
                            
                        }
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
    
    
    
    //TODO: Signup Service
    private func hitSignupService(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let dataListVM_T = self.userDataVM else{
            print("No dataListVM_T found...")
            return
        }
        
        guard let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String else {
            print("No FirebaseId found...")
            return
        }
        
        let parameters = [Api_keys_model.social_unique_id:ConstantTexts.empty,
                          Api_keys_model.device_type:ConstantTexts.deviceTypeNew,
                          Api_keys_model.device_token:FirebaseId,
                          Api_keys_model.device_id: FirebaseId,
                          Api_keys_model.full_name:dataListVM_T.dataStoreStructAtIndex(0).value,
                          Api_keys_model.first_name: self.getFirstNameAndLastName(from: dataListVM_T.dataStoreStructAtIndex(0).value).0,
                          Api_keys_model.last_name: self.getFirstNameAndLastName(from: dataListVM_T.dataStoreStructAtIndex(0).value).1,
                          Api_keys_model.email:dataListVM_T.dataStoreStructAtIndex(1).value,
                          Api_keys_model.mobile:"\(ConstantTexts.CountryCode_LT)\(dataListVM_T.dataStoreStructAtIndex(2).value)",
                          Api_keys_model.password:dataListVM_T.dataStoreStructAtIndex(3).value] as [String:AnyObject]
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.signup, method: .post, parameters: parameters, header: nil, success: { (result) in
            print(result)
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        if let responseDict = result_Dict.value(forKey: "response") as? NSDictionary{
                            
                            
                            if let userData = self.customMethodManager?.getUserModelFromApi(responseDict: responseDict){
                                self.customMethodManager?.saveDataToLocal_DB(userData: userData, callBack: {
                                    
                                    if userData.status == "underreview" || userData.status == "approved" {
                                        let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
                                        UIApplication.shared.windows.first?.rootViewController = vc
                                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                                    }else{
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: OnBoardingVC.className)
                                    }
                                    
                                    
                                })
                            }
                            
                            
                        }
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


//MARK: - Web services Get OTP from firebase
extension OTP_VC{
    //TODO: Check firebase OTP
    private func checkFireBaseOTP(){
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        if let otpText = self.dataListVM?.dataStoreStructAtIndex(0).value{
            UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.authVerificationID, verificationCode: otpText)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    UtilityHelper.sharedInstance.hideActivityIndicator()
                    print(error.localizedDescription)
                    let indexPath = IndexPath(row: 0, section: 0)
                    if let cell = self.otpTable.cellForRow(at: indexPath) as? Auth_TextField_TableViewCell{
                        self.customMethodManager?.showToolTip(msg: ConstantTexts.EnteredValidOTPInvalidALERT, anchorView: cell.textFieldFloating, sourceView: self.view)
                        cell.textFieldFloating.becomeFirstResponder()
                    }
                } else {
                    UtilityHelper.sharedInstance.hideActivityIndicator()
                    print(authResult?.user)
                    if self.isComingFromSignIn{
                        self.hitLoginService()
                    }else{
                        self.hitSignupService()
                    }
                }
            }
        }
    }
    
    
    
    // 
    internal func resendFireBaseOTP(){
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        var phoneNumber:String = String()
        if self.isComingFromSignIn{
            phoneNumber = "\(ConstantTexts.CountryCode_LT)\(self.userDataVM?.dataStoreStructAtIndex(0).value ?? String())"
        }else{
            phoneNumber = "\(ConstantTexts.CountryCode_LT)\(self.userDataVM?.dataStoreStructAtIndex(2).value ?? String())"
        }
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                //self.showMessagePrompt(error.localizedDescription)
                UtilityHelper.sharedInstance.hideActivityIndicator()
                self.customMethodManager?.showAlert(error.localizedDescription, okButtonTitle: ConstantTexts.OkBT, target: nil)
                return
            }else{
                UtilityHelper.sharedInstance.hideActivityIndicator()
                
                if let verificationID = verificationID{
                    self.authVerificationID = verificationID
                }
                _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: ConstantTexts.SendOTPYourPhoneALERT, style: .success)
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
        }
    }
}
