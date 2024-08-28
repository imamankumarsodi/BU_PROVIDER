//
//  SignUpVC+MethodExtension.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseAuth
extension SignUpVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        super.isHiddenNavigationBar(true)
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.signUpModel == nil {
            self.signUpModel = SignUpVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.signUpModel?.prepareDataSource()
        }
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.header.lblHeaderTitle.text = ConstantTexts.SignUpLT
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.AlreadyHaveLT) ", font: AppFont.Medium.size(AppFontName.Montserrat, size: 16), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.SignInNewLT)", font: AppFont.Medium.size(AppFontName.Montserrat, size: 16), color: AppColor.app_blue_color) ?? NSMutableAttributedString())
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.footer.lblSignUpRef.attributedText = myMutableString
        
        let lblSignIn_Tap = UITapGestureRecognizer(target: self, action: #selector(self.lblSignInRefTapped(_:)))
        self.footer.lblSignUpRef.isUserInteractionEnabled = true
        self.footer.lblSignUpRef.addGestureRecognizer(lblSignIn_Tap)
        
        self.footer.btnContinueRef.addTarget(self, action: #selector(btnbtnContinueTapped), for: .touchUpInside)
       
        registerNib()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.signUpTable.register(nib: Auth_TextField_TableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
    }
    
    
    //TODO: setup validation
    internal func isValidate(){
        super.dismissKeyboard()
        if let dataListVM_T = self.dataListVM{
            self.signUpModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    self.hitCheckMobilenumberService()
                    
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    if let cell = self.signUpTable.cellForRow(at: indexPath) as? Auth_TextField_TableViewCell{
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        cell.textFieldFloating.becomeFirstResponder()
                    }
                }
            })
        }
    }
}



//MARK: - Extension web services
extension SignUpVC{
    
    //MARK: - Web services
    //TODO: Check mobile number existense in database
    private func hitCheckMobilenumberService(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let dataListVM_T = self.dataListVM else{
            print("No dataListVM_T found...")
            return
        }
        let parameters = [Api_keys_model.mobile:"\(ConstantTexts.CountryCode_LT)\(dataListVM_T.dataStoreStructAtIndex(2).value)",
                          Api_keys_model.email:dataListVM_T.dataStoreStructAtIndex(1).value] as [String:AnyObject]
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.checkMobilenumber, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                            self.hitGetFireBaseOTP()
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
extension SignUpVC{
    //TODO: Get OTP from firebase
    private func hitGetFireBaseOTP(){
   
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        let phoneNumber = "\(ConstantTexts.CountryCode_LT)\(self.dataListVM?.dataStoreStructAtIndex(2).value ?? String())"
        
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
          if let error = error {
            //self.showMessagePrompt(error.localizedDescription)
            UtilityHelper.sharedInstance.hideActivityIndicator()

            self.customMethodManager?.showAlert(error.localizedDescription, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
          }else{
            
            UtilityHelper.sharedInstance.hideActivityIndicator()

            let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: OTP_VC.className) as! OTP_VC
            vc.userDataVM = self.dataListVM
            
            if let verificationID = verificationID{
                vc.authVerificationID = verificationID
            }
            self.navigationController?.pushViewController(vc, animated: true)
          }
          // Sign in using the verificationID and the code sent to the user
          // ...
        }
    }
    
}
