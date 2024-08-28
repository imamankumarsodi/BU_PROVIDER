//
//  HomeVC+MethodExtension.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
import ViewAnimator
import CoreLocation


extension HomeVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = false
        super.setupNavigationBarTitle(AppColor.header_color,false,ConstantTexts.DashbordLT, AppColor.whiteColor, leftBarButtonsType: [.empty], rightBarButtonsType: [.empty])
        super.isHiddenNavigationBar(false)
      
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
        if self.homeVM == nil {
            self.homeVM = HomeVM.shared
        }
        
        self.initialSetup()
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        if user.status == "approved"{
            self.lblAccountActive.isHidden = false
            self.lblUnderReview.isHidden = true

        }else{
            self.lblAccountActive.isHidden = true
            self.lblUnderReview.isHidden = false
            
        }
        
        self.setName("\(user.first_name) \(user.last_name)", user.email)
     
        self.draggableView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
        self.registerNib()
        
        
        
    }
    
    
    //TODO: Set name
    internal func setName(_ name:String,_ profession:String){
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: name, font: AppFont.Medium.size(AppFontName.Montserrat, size: 14), color: AppColor.header_color) ?? NSMutableAttributedString())
        
        myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\n\(profession)", font: AppFont.Regular.size(AppFontName.Montserrat, size: 12), color: AppColor.header_color) ?? NSMutableAttributedString())
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblTitle.attributedText = myMutableString
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        
        self.categoryCollectionView.register(nib: HomeCollectionViewCellAndXib.className)
        self.categoryListVM = self.homeVM?.prepareDataSourceStatic()
        super.determineCurrentLocation()
        super.getLocationCallBack = { (lat,long) in
            print(lat)
            print(long)
           /* self.navigationController?.navigationBar.largeContentTitle = address
            self.navigationController?.navigationItem.title = address */
            self.lati = "\(lat)"
            self.longi = "\(long)"
           /* self.getAddressFromLatLon(pdblLatitude: "\(lat)", withLongitude: "\(long)")
            self.hitgetCategoriesService(lat: "\(lat)", long: "\(long)", service_type: String()) */
        }
        
        
    }
    
    
    //TODO: Animate rotate collection view
    internal func runRotateAnimation(){
        
        UIView.animate(views: self.categoryCollectionView.visibleCells,
                       animations: [zoomAnimation, rotateAnimation],
                       duration: 0.5)
    }
    
    //TODO: Animate rotate collection view
    internal func animateView(){
        self.runRotateAnimation()
    }
    
    //TODO: Reload collection view
    internal func reloadCollectionView(){
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
    }
    
    //TODO: Get address from lat lon
    internal func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        if  let pm = placemarks as? [CLPlacemark]{
                                            
                                            if pm.count > 0 {
                                                let pm = placemarks![0]
                                                print(pm.country)
                                                print(pm.locality)
                                                print(pm.subLocality)
                                                print(pm.thoroughfare)
                                                print(pm.postalCode)
                                                print(pm.subThoroughfare)
                                                var addressString : String = ""
                                                if pm.subLocality != nil {
                                                    addressString = addressString + pm.subLocality! + ", "
                                                }
                                                /*  if pm.thoroughfare != nil {
                                                    addressString = addressString + pm.thoroughfare! + ", "
                                                } */
                                                if pm.locality != nil {
                                                    addressString = addressString + pm.locality! + ", "
                                                }
                                                if pm.country != nil {
                                                    addressString = addressString + pm.country! + " "
                                                }
                                              /*  if pm.postalCode != nil {
                                                    addressString = addressString + pm.postalCode! + " "
                                                } */
                                                
                                                print(addressString)
                                                /* self.navigationTitle = addressString
                                                self.navigationController?.navigationBar.topItem?.title = self.navigationTitle */
                                            
                                            }
                                        }
                                        
                                    })
    }
    
}



//MARK: - Extension web services
extension HomeVC{
    //MARK: - Web services
    //TODO: Signup Service
    internal func hitgetCategoriesService(lat:String,long:String,service_type:String){
        
        if !NetworkState.isConnected() {
            customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
            return
        }
        
        
        
        
        
        var parameters: [String:AnyObject] = [String:AnyObject]()
        
        
        /*
         
        // FOR SHOWING DATA TO CLIENT ACCORDING TO LOCATION
         if service_type == ConstantTexts.empty{
             parameters = [Api_keys_model.latitute:"\(lat)",
                              Api_keys_model.lang:"\(long)"] as [String:AnyObject]
         }else{
             parameters = [Api_keys_model.latitute:"\(lat)",
                              Api_keys_model.lang:"\(long)",
                              Api_keys_model.service_type:service_type] as [String:AnyObject]
         }
         **/
        
        
        
    
         
         // FOR SHOWING DATA TO CLIENT ACCORDING TO WITHOUR LOCATION
        if service_type == ConstantTexts.empty{
           print("Do nothing...")
        }else{
            parameters = [Api_keys_model.service_type:service_type] as [String:AnyObject]
        }
        
        
        
        
        
        UtilityHelper.sharedInstance.showActivityIndicatorWith(color: AppColor.header_color,view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.categories, method: .post, parameters: parameters, header: nil, success: { (result) in
            UtilityHelper.sharedInstance.hideActivityIndicatorWith(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "status") as? Int{
                    if code == 200{
                        print(result_Dict)
                        if let responseArray = result_Dict.value(forKey: "response") as? NSArray{
                            if  self.categoryListVM == nil{
                                   self.categoryListVM = self.homeVM?.prepareDataSource(with: responseArray)
                            }else{
                                if let categories = self.homeVM?.prepareDataSource(with: responseArray).categories{
                                    self.categoryListVM?.categories.append(contentsOf: categories)
                                }
                            }
                            self.reloadCollectionView()
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
            UtilityHelper.sharedInstance.hideActivityIndicatorWith(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

            }
        }
    }
}
