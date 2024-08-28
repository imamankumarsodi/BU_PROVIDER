//
//  BankDetailsVC+CustomMethod.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit
import FirebaseAuth
extension BankDetailsVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.bankDetails_LT, AppColor.whiteColor, leftBarButtonsType: [.back], rightBarButtonsType: [])
        super.isHiddenNavigationBar(false)
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.otpModel == nil {
            self.otpModel = BankDetailsVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.otpModel?.prepareDataSource()
        }
        
        if self.docDataModeling == nil{
            self.docDataModeling = UploadDocumentVM.shared
        }
        
        
        if self.docDataList == nil{
            self.docDataList = docDataModeling?.prepareDataSource()
        }
        
        
        
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){


        // self.footer.imgDoc.addDashedBorder()
        
        self.footer.btnSelectImage.addTarget(self, action: #selector(btnChooseTapped), for: .touchUpInside)
        self.footer.btnContinueRef.addTarget(self, action: #selector(btnSaveTapped), for: .touchUpInside)

        
        registerNib()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.tblIDProof.register(nib: IDProofTableViewCell.className)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
        }
    }
    
    
    
    //TODO: Methods for picker (Image picker and document picker)
    public func openActionSheet() {
        
        let alert = UIAlertController(title: APP_NAME, message: ConstantTexts.SelectYourOptionLT, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: ConstantTexts.CameraLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            super.openCamera()
        }
        let gallaryAction = UIAlertAction(title: ConstantTexts.GalleryLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            super.openGallery()
        }
        
        
        let document = UIAlertAction(title: ConstantTexts.DocumetsLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            super.openDocuments()
        }
        
        let cancelAction = UIAlertAction(title: ConstantTexts.CancelBT, style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(document)
        alert.addAction(cancelAction)
        super.present(alert, animated: true, completion: nil)
        
        super.getDocCallBack = { item in
           
            self.docDataList?.documentDataItems.append(item)
            print(self.docDataList?.documentDataItems.count)
            self.footer.imgDoc.image = UIImage(data: item.data)
            self.footer.btnSelectImage.isUserInteractionEnabled = false
            
        }
        
    }
    
    
    
    //TODO: setup validation
    internal func isValidate(){
        super.dismissKeyboard()
        if let dataListVM_T = self.dataListVM{
            self.otpModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    
                self.hitUploadBankDetails()
                   
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    if let cell = self.tblIDProof.cellForRow(at: indexPath) as? IDProofTableViewCell{
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
extension BankDetailsVC{
    
    
    //MARK: - V2 Web Services
    //TODO: Multiple_doc Service
    internal func hitUploadBankDetails(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        guard  let docArray = self.docDataList?.documentDataItems  else {
            print("No docArray found...")
            return
        }
        
        guard let dataListVM_T = self.dataListVM else{
            print("No dataListVM_T found...")
            return
        }
        
      
        let parameters = [Api_keys_model.bank_provider_id:user.id,
         Api_keys_model.bank_holder_name:dataListVM_T.dataStoreStructAtIndex(0).value,
         Api_keys_model.bank_account_number:dataListVM_T.dataStoreStructAtIndex(1).value,
         Api_keys_model.bank_ifsc_code:dataListVM_T.dataStoreStructAtIndex(2).value] as [String:AnyObject]
        
        
        let header = ["Authorization":user.access_token,
                      "Content-Type":"application/json",
                      "Accept":"application/json"]
        
        UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)

        ServiceClass.shared.multipartImageServiceWithArrayObject(url: SAuthApi.addUpdatebank, docArray, header: header, parameters: parameters, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicator()
            print(result)
            
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        
                        self.customMethodManager?.updateStatus(id: user.id, status: "underreview")
                        self.callBackBank?()
                        _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: ConstantTexts.ProfileUpdateALERT, style: .success)
                        self.navigationController?.popViewController(animated: true)



                    }else{
                        
                       /* self.customMethodManager?.updateStatus(id: user.id, status: "underreview")
                        self.callBackBank?()
                        _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: ConstantTexts.ProfileUpdateALERT, style: .success)
                        self.navigationController?.popViewController(animated: true) */
                        
                        
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


