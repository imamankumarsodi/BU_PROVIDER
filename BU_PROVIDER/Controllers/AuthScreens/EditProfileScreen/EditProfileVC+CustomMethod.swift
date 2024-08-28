//
//  EditProfileVC+CustomMethod.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
import FirebaseAuth
import CoreData
extension EditProfileVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.EditProfileTitle, AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [])
        super.isHiddenNavigationBar(false)
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.otpModel == nil {
            self.otpModel = PersonalDetailsVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.otpModel?.prepareDataSourceLocal()
        }
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){


        self.footer.lblSignUpRef.isHidden = true
        self.footer.btnContinueRef.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)

        //create the Toolbar for Cancel and Done buttons
        createUIToolBar()
        
        //set date picker mode
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        //iOS 14 or greater
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
       
        
        registerNib()
    }
    
    
    func createUIToolBar() {
        
        pickerToolbar = UIToolbar()
        pickerToolbar?.autoresizingMask = .flexibleHeight
        
        //customize the toolbar
        pickerToolbar?.barStyle = .default
        pickerToolbar?.barTintColor = UIColor.black
        pickerToolbar?.backgroundColor = UIColor.white
        pickerToolbar?.isTranslucent = false
        
        //add buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:
                                            #selector(self.cancelBtnClicked(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
                                            #selector(self.doneBtnClicked(_:)))
        doneButton.tintColor = UIColor.white
        
        //add the items to the toolbar
        pickerToolbar?.items = [cancelButton, flexSpace, doneButton]
        
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.tblPersonalInfo.register(nib: IDProofTableViewCell.className)
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
                    
                   self.hitUpDateProfile()
                   
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    if let cell = self.tblPersonalInfo.cellForRow(at: indexPath) as? IDProofTableViewCell{
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        if row != 1{
                            cell.textFieldFloating.becomeFirstResponder()
                        }
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
extension EditProfileVC{
    //MARK: - Web services
    //TODO: Signup Service
    internal func hitUpDateProfile(){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        
        var user_saved = UserDataModel(access_token: String(), device_id: String(), device_token: String(), device_type: String(), email: String(), first_name: String(), full_name: String(), id: String(), last_name: String(), latitude: String(), longitude: String(), picture: String(), rating: String(), rating_count: String(), social_unique_id: String(), mobile: String(), stripe_cust_id: String(), wallet_balance: String(), login_by: String(), status: String(),dob:String(), gender:String(), parent_name:String(),address_type:String(),house_no:String(),locality:String(),statename:String(),cityname:String(),pincode:String())
        
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        user_saved = user
        
        
        guard let dataListVM_T = self.dataListVM else{
            print("No dataListVM_T found...")
            return
        }
        

        
        let parameters = [Api_keys_model.provider_id:user.id,
                          Api_keys_model.user_id:user.id,
                          Api_keys_model.first_name:dataListVM_T.dataStoreStructAtIndex(0).value,
                          Api_keys_model.last_name:dataListVM_T.dataStoreStructAtIndex(1).value,
                          Api_keys_model.mobile:dataListVM_T.dataStoreStructAtIndex(2).value] as [String:AnyObject]
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.profile_update, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            if let result_Dict = result as? NSDictionary{
                print(result_Dict)
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                       
                       /* self.customMethodManager?.updateStatus(id: user.id, status: "personaldetails")
                        self.updateParent(id: user.id, user: user_saved)
                        self.callBackPersonal?() */
                        self.navigationController?.popViewController(animated: true)
                       

                    }else{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                        
                        
                        /*  self.customMethodManager?.updateStatus(id: user.id, status: "personaldetails")
                        self.updateParent(id: user.id, user: user_saved)
                        self.callBackPersonal?()
                        self.navigationController?.popViewController(animated: true) */
    
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
    
    
    func updateParent(id:String,user:UserDataModel){
        
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User_Data")
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let result = try context.fetch(request)
            if result.count > 0{
                let filterObject = result.first as! NSManagedObject
                filterObject.setValue(user.parent_name, forKey: "parent_name")
                filterObject.setValue(user.dob, forKey: "dob")
                filterObject.setValue(user.gender, forKey: "gender")

                
                do{
                    try context.save()
                }catch{
                    print("Failed")
                }
            }
        } catch {
            print("Failed")
        }
    }
}


