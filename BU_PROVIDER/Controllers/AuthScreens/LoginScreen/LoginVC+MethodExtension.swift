//
//  LoginVC+MethodExtension.swift
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
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import AuthenticationServices



extension LoginVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        super.isHiddenNavigationBar(true)
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.logInModel == nil {
            self.logInModel = LoginVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.logInModel?.prepareDataSource()
        }
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.header.lblHeaderTitle.text = ConstantTexts.SignInLT
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.DidntHaveAnLT) ", font: AppFont.Medium.size(AppFontName.Montserrat, size: 16), color: AppColor.app_theame_color) ?? NSMutableAttributedString())
        
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.SignUpNewLT)", font: AppFont.Medium.size(AppFontName.Montserrat, size: 16), color: AppColor.app_blue_color) ?? NSMutableAttributedString())
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.footer.lblSignUpRef.attributedText = myMutableString
        
        
        let lblSignUpRef_Tap = UITapGestureRecognizer(target: self, action: #selector(self.lblSignUpRefTapped(_:)))
        self.footer.lblSignUpRef.isUserInteractionEnabled = true
        self.footer.lblSignUpRef.addGestureRecognizer(lblSignUpRef_Tap)
        
        self.footer.btnContinueRef.addTarget(self, action: #selector(btnbtnContinueTapped), for: .touchUpInside)
        
        
        self.footer.btnFBRef.addTarget(self, action: #selector(btnFBTapped), for: .touchUpInside)
        
        self.footer.btnGmailRef.addTarget(self, action: #selector(btnGmailTapped), for: .touchUpInside)
        
        self.footer.btnAppleRef.addTarget(self, action: #selector(btnAppleTapped), for: .touchUpInside)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        registerNib()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.logInTable.register(nib: Auth_TextField_TableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
    }
    
    
    //TODO: setup validation
    internal func isValidate(){
        super.dismissKeyboard()
        if let dataListVM_T = self.dataListVM{
            self.logInModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    self.hitCheckMobilenumberService()
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    if let cell = self.logInTable.cellForRow(at: indexPath) as? Auth_TextField_TableViewCell{
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        cell.textFieldFloating.becomeFirstResponder()
                    }
                }
            })
        }
    }
    
}



//MARK: - Extension web services
extension LoginVC{
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
        let parameters = [Api_keys_model.mobile:"\(ConstantTexts.CountryCode_LT)\(dataListVM_T.dataStoreStructAtIndex(0).value)",
                          Api_keys_model.email:ConstantTexts.empty] as [String:AnyObject]
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.checkMobilenumber, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                    }else{
                        self.hitGetFireBaseOTP()
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
    
    
    private func hitSocialLoginService(user:UserDataModel){
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String else {
            print("No FirebaseId found...")
            return
        }
        
        
        let parameters = [Api_keys_model.social_unique_id:user.social_unique_id,
                          Api_keys_model.login_by:user.login_by,
                          Api_keys_model.first_name:user.first_name,
                          Api_keys_model.last_name:user.last_name,
                          Api_keys_model.email:user.email,
                          Api_keys_model.mobile:user.mobile,
                          Api_keys_model.device_type:user.device_type,
                          Api_keys_model.device_token:FirebaseId,
                          Api_keys_model.device_id:FirebaseId] as [String:AnyObject]
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.social_login, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        
                        print(result_Dict)
                        if let responseDict = result_Dict.value(forKey: "response") as? NSDictionary{
                            
                            
                            if let userData = self.customMethodManager?.getUserModelFromApi(responseDict: responseDict){
                                self.customMethodManager?.saveDataToLocal_DB(userData: userData, callBack: {
                                   /* let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
                                    UIApplication.shared.windows.first?.rootViewController = vc
                                    UIApplication.shared.windows.first?.makeKeyAndVisible() */
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


//MARK: -  Extension facebook services
extension LoginVC{
    internal func FBLoginSetup()
    {
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        
    
        let login = LoginManager()
            login.logIn(
                permissions: ["email","public_profile"],
                from: self,
                handler: { result, error in
                    UtilityHelper.sharedInstance.hideActivityIndicator()
                    if error != nil {
                        print("Process error")
                    } else if ((result?.isCancelled) != nil) {
                        print("Cancelled")
                    } else {
                        print("Logged in")
                        self.getFbData()
                        login.logOut()
                    }
                })
    
 
        
    }
    
    
    
    private func getFbData()
    {
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        if (AccessToken.current != nil) {
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id ,name , first_name , last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) in
                UtilityHelper.sharedInstance.hideActivityIndicator()
                
                if error != nil{
                    print("Get error\(error?.localizedDescription)")
                }
                else{
                    if let dataDict = result as? [String : AnyObject]{
                        print(dataDict)
                        var user = UserDataModel(access_token: String(), device_id: String(), device_token: String(), device_type: String(), email: String(), first_name: String(), full_name: String(), id: String(), last_name: String(), latitude: String(), longitude: String(), picture: String(), rating: String(), rating_count: String(), social_unique_id: String(), mobile: String(), stripe_cust_id: String(), wallet_balance: String(), login_by: String(), status: String(),dob:String(), gender:String(), parent_name:String(),address_type:String(),house_no:String(),locality:String(),statename:String(),cityname:String(),pincode:String())
                        if let socialID = dataDict["id"] as? String {
                            user.social_unique_id = socialID
                        }
                        if let first_name = dataDict["first_name"] as? String {
                            user.first_name = first_name
                            
                        }
                        
                        if let status = dataDict["status"] as? String {
                            user.status = status
                            
                        }
                        
                        if let last_name = dataDict["last_name"] as? String {
                            user.last_name = last_name
                        }
                        if let name = dataDict["name"] as? String {
                            user.full_name = name
                        }
                        if let email = dataDict["email"] as? String{
                            user.email = email
                        }
                        
                        
                        if let pictureDict = dataDict["picture"] as? [String:AnyObject]{
                            if let pictureData = pictureDict["data"] as? [String:AnyObject]{
                                if let url = pictureData["url"] as? String {
                                    user.picture = url
                                }
                                
                            }
                        }
                        
                        if let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String {
                            user.device_token = FirebaseId
                        }
                        
                        if let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String {
                            user.device_id = FirebaseId
                        }
                        
                        user.device_type = ConstantTexts.deviceTypeNew
                        user.login_by = ConstantTexts.FaceBook_LT
                        self.hitSocialLoginService(user:user)
                    }
                }
            })
        }
    }
}


//MARK: - Web services Get OTP from firebase
extension LoginVC{
    private func hitGetFireBaseOTP(){
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        guard let dataListVM_T = self.dataListVM else{
            print("No dataListVM_T found...")
            return
        }
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        
        let phoneNumber = "\(ConstantTexts.CountryCode_LT)\(dataListVM_T.dataStoreStructAtIndex(0).value)"
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
                vc.isComingFromSignIn = true
                
                if let verificationID = verificationID{
                    print(verificationID)
                    vc.authVerificationID = verificationID
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
        }
    }
}



//MARK: - Extension google signIn
extension LoginVC:GIDSignInDelegate{
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,withError error: Error!) {
        UtilityHelper.sharedInstance.hideActivityIndicator()
        if error != nil {
            print("\(error.localizedDescription)")
        }
        else
        {
            
            var userN = UserDataModel(access_token: String(), device_id: String(), device_token: String(), device_type: String(), email: String(), first_name: String(), full_name: String(), id: String(), last_name: String(), latitude: String(), longitude: String(), picture: String(), rating: String(), rating_count: String(), social_unique_id: String(), mobile: String(), stripe_cust_id: String(), wallet_balance: String(), login_by: String(), status: String(),dob:String(), gender:String(), parent_name:String(),address_type:String(),house_no:String(),locality:String(),statename:String(),cityname:String(),pincode:String())
            
            if let profilePicUrlString = user.profile.imageURL(withDimension: 300) as? String{
                userN.picture = profilePicUrlString
            }
            
            
            if  let userId = user.userID{
                userN.social_unique_id = userId
            }
            
            if let idToken = user.authentication.idToken{
                userN.id = idToken
            }// Safe to send to the server
            
            
            if let fullName = user.profile.name {
                userN.full_name = fullName
            }
            
            
            if let givenName = user.profile.givenName{
                userN.first_name = givenName
            }
            
            if let familyName = user.profile.familyName{
                userN.last_name = familyName
                
            }
            
            if let email = user.profile.email {
                userN.email = email
            }
            
            if let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String {
                userN.device_token = FirebaseId
            }
            
            if let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String {
                userN.device_id = FirebaseId
            }
            
            
            
            
            
            
            userN.device_type = ConstantTexts.deviceTypeNew
            userN.login_by = ConstantTexts.Google_LT
            self.hitSocialLoginService(user:userN)
            
        }
    }
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}




extension LoginVC:ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    
    //Apple login
    @available(iOS 13.0, *)
    @objc func hitAppleLogin() {
        
        handleLogInWithAppleIDButtonPress()
    }
    
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    @available(iOS 13.0, *)
    private func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    @available(iOS 13.0, *)
    @objc private func handleLogInWithAppleIDButtonPress() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
  
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: appleIDCredential.user) {  (credentialState, error) in
                switch credentialState {
                case .authorized:
                    print("The Apple ID credential is valid")
                    
                    var userN = UserDataModel(access_token: String(), device_id: String(), device_token: String(), device_type: String(), email: String(), first_name: String(), full_name: String(), id: String(), last_name: String(), latitude: String(), longitude: String(), picture: String(), rating: String(), rating_count: String(), social_unique_id: String(), mobile: String(), stripe_cust_id: String(), wallet_balance: String(), login_by: String(), status: String(),dob:String(), gender:String(), parent_name:String(),address_type:String(),house_no:String(),locality:String(),statename:String(),cityname:String(),pincode:String())
                   
                    
                    if let username = appleIDCredential.fullName{
                        userN.first_name = username.givenName ?? ""
                        userN.last_name = username.familyName ?? ""
                       /* self.fNameApple = "\(username.givenName ?? "")"
                        self.LNameApple = "\(username.familyName ?? "")" */
                        userN.full_name = "\(userN.first_name) \(userN.last_name)"
                    }
                    
                    if let userEmail = appleIDCredential.email {
                        userN.email = userEmail
                       // self.emailApple = userEmail
                    }
                    
                  
                    let userIdentifier = appleIDCredential.user
                    userN.social_unique_id = userIdentifier
                    userN.social_unique_id = userIdentifier
                  
                 
                 
                    if let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String {
                        userN.device_token = FirebaseId
                    }
                    
                    if let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String {
                        userN.device_id = FirebaseId
                    }
                    
                    userN.device_type = ConstantTexts.deviceTypeNew
                    userN.login_by = ConstantTexts.Google_LT
                    
                    
                    
                    
               
                    DispatchQueue.main.async {
                        self.hitSocialLoginService(user:userN)
                    }
                    
                    
                    break
                case .revoked:
                    print("The Apple ID credential is revoked")
                    // The Apple ID credential is revoked.
                    break
                case .notFound:
                    print("The Apple ID credential is  sign-in UI")
                // No credential was found, so show the sign-in UI.
                default:
                    break
                }
            }
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("username:",username)
            print("password:",password)
            
            //Navigate to other view controller
        }
    }
    
    
    
    
    
}
