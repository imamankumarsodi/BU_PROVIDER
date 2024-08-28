//
//  CustomMethodClass.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
import Lottie
import DropDown
import CoreData
import SDWebImage
class CustomMethodClass: CustomMethodProtocol {
    
    //TODO: Singleton object
    static let shared = CustomMethodClass()
    private init() {}
    
    
    //TODO: Set url image on imageview
    func setImage(imageView:UIImageView,url:String){
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: url))
    }
    
    //MARK: - Alert Methods
    //TODO: Show alert simple
    func showAlert(_ message: String, okButtonTitle: String? = nil, target: UIViewController? = nil) {
        let topViewController: UIViewController? = self.topMostViewController(rootViewController: self.rootViewController())
        
        if let _ = topViewController {
            let alert = UIAlertController(title:APP_NAME, message: message, preferredStyle: UIAlertController.Style.alert);
            let okBtnTitle = okButtonTitle
            let okAction = UIAlertAction(title:okBtnTitle, style: UIAlertAction.Style.default, handler: nil);
            
            alert.addAction(okAction);
            if UIApplication.shared.applicationState != .background{
                topViewController?.present(alert, animated:true, completion:nil);
            }
        }
    }
    
    
    //TODO: Show alert with cancel
    func showAlertWithCancel(title:String,message:String,btnOkTitle:String,btnCancelTitle:String,callBack:@escaping ((Bool)->())){
        
        let topViewController: UIViewController? = self.topMostViewController(rootViewController: self.rootViewController())
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnOkTitle, style: .default, handler: { action in
            callBack(true)
        }))
        alert.addAction(UIAlertAction(title: btnCancelTitle, style: .cancel, handler: { action in
            callBack(false)
        }))
        
        topViewController?.present(alert, animated: true)
    }
    
    //TODO: Show alert with cancel
    func showAlertWithOK(title:String,message:String,btnOkTitle:String,callBack:@escaping ((Bool)->())){
        let topViewController: UIViewController? = self.topMostViewController(rootViewController: self.rootViewController())
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnOkTitle, style: .default, handler: { action in
            callBack(true)
        }))
        topViewController?.present(alert, animated: true)
    }
    
    
    //TODO: Get root view controller
    func rootViewController() -> UIViewController
    {
        return UIApplication.shared.windows.first!.rootViewController ?? UIViewController()
    }
    
    
    
    //TODO - Get topmost view controller
    func topMostViewController(rootViewController: UIViewController) -> UIViewController? {
        if let navigationController = rootViewController as? UINavigationController
        {
            return topMostViewController(rootViewController: navigationController.visibleViewController!)
        }
        
        if let tabBarController = rootViewController as? UITabBarController
        {
            if let selectedTabBarController = tabBarController.selectedViewController
            {
                return topMostViewController(rootViewController: selectedTabBarController)
            }
        }
        
        if let presentedViewController = rootViewController.presentedViewController
        {
            return topMostViewController(rootViewController: presentedViewController)
        }
        return rootViewController
    }
    
    
    //TODO: Show ToolTip
    func showToolTip(msg:String,anchorView:UIView,sourceView:UIView){
        let rightBottomView = TipView()
        rightBottomView.color = AppColor.errorColor
        rightBottomView.textColor = AppColor.whiteColor
        rightBottomView.font = AppFont.SemiBold.size(AppFontName.Montserrat, size: 12)
        rightBottomView.maxWidth = anchorView.frame.size.width - 50
        rightBottomView.dismissClosure = { tipview in
            print("call back to there..")
        }
        // Dismiss after spwcified duration
        rightBottomView.show(message: msg,
                             sourceView: anchorView,
                             containerView: sourceView,
                             direction: .top, dismissAfterDuration: 2.0)
    }
    
    //TODO: Show ToolTip
    func showToolTipBottom(msg:String,anchorView:UIView,sourceView:UIView){
        let rightBottomView = TipView()
        rightBottomView.color = AppColor.errorColor
        rightBottomView.textColor = AppColor.whiteColor
        rightBottomView.font = AppFont.SemiBold.size(AppFontName.Montserrat, size: 12)
        rightBottomView.maxWidth = anchorView.frame.size.width - 50
        rightBottomView.dismissClosure = { tipview in
            print("call back to there..")
        }
        // Dismiss after spwcified duration
        rightBottomView.show(message: msg,
                             sourceView: anchorView,
                             containerView: sourceView,
                             direction: .bottom, dismissAfterDuration: 2.0)
    }
    
    
    
    //TODO: Provide corner radius
    func provideCornerRadiusTo(_ view:UIView, _ radius:CGFloat, _ corners:CACornerMask){
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.layer.maskedCorners = corners
    }
    
    //TODO: Provide shadow, border and corner radius
    func provideShadowAndCornerRadius(_ blueView:UIView, _ cornerRadius:CGFloat,_ corners:CACornerMask,_ shadowColor: UIColor, _ shadowWidth: CGFloat, _ shadowHeight: CGFloat,_ shadowOpacity: Float, _ shadowRadius: CGFloat, _ borderWidth:CGFloat, _ borderColor: UIColor){
        // corner radius
        blueView.layer.cornerRadius = cornerRadius
        blueView.layer.maskedCorners = corners
        
        // border
        blueView.layer.borderWidth = borderWidth
        blueView.layer.borderColor = borderColor.cgColor
        
        // shadow
        blueView.layer.shadowColor = shadowColor.cgColor
        blueView.layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        blueView.layer.shadowOpacity = shadowOpacity
        blueView.layer.shadowRadius = shadowRadius
    }
    
    //TODO: Provide border
    public func provideCornerBorderTo(_ item: UIView, _ border: CGFloat,_ borderColor: UIColor) {
        item.layer.borderColor = borderColor.cgColor
        item.layer.borderWidth = border
        item.clipsToBounds = true
    }
    
    
    //TODO: Provide AttributedText
    public func provideSimpleAttributedText( text:String, font: UIFont,  color: UIColor)->NSMutableAttributedString{
        return NSMutableAttributedString(string: "\(text)", attributes:[.font: font, .foregroundColor :color])
    }
    
    
    //TODO: Provide underline AttributedText
    public func provideUnderlineAttributedText( text:String, font: UIFont, _ color: UIColor)->NSMutableAttributedString{
        return NSMutableAttributedString(string: "\(text)", attributes:[.font: font, .foregroundColor :color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    
    //TODO: Open drop down
    public func openDownOnView(dropDown:DropDown,array:[String],anchor:UIView,callBack:((_ dropDown:DropDown)->())){
        dropDown.anchorView = anchor
        dropDown.width = anchor.frame.size.width
        dropDown.dataSource = array
        /* dropDown.backgroundColor = AppColor.bgColor
         dropDown.textColor = AppColor.whiteColor */
        dropDown.bottomOffset = CGPoint(x: 0, y:anchor.bounds.height)
        dropDown.direction = .any
        dropDown.show()
        
        callBack(dropDown)
    }
    
    //TODO: Open drop down bottom direction
    public func openDownOnViewBottomDirection(dropDown:DropDown,array:[String],anchor:UIView,callBack:((_ dropDown:DropDown)->())){
        dropDown.anchorView = anchor
        dropDown.width = anchor.frame.size.width
        dropDown.dataSource = array
        /* dropDown.backgroundColor = AppColor.bgColor
         dropDown.textColor = AppColor.whiteColor */
        dropDown.bottomOffset = CGPoint(x: 0, y:anchor.bounds.height)
        dropDown.direction = .bottom
        dropDown.show()
        
        callBack(dropDown)
    }
    
    
    
    //TODO: Get indexPath for tableview cell
    func getIndexPathFor(view: UIView, tableView: UITableView) -> IndexPath? {
        let point = tableView.convert(view.bounds.origin, from: view)
        let indexPath = tableView.indexPathForRow(at: point)
        return indexPath
    }
    
    //TODO: Get indexPath for collectionview cell
    func getIndexPathForCollectionView(view: UIView, collectionView: UICollectionView) -> IndexPath? {
        let point = collectionView.convert(view.bounds.origin, from: view)
        let indexPath = collectionView.indexPathForItem(at: point)
        return indexPath
    }
    
    
    //MARK: - Methods for coredata
    //TODO: Save data to local database
    func saveDataToLocal_DB(userData:UserDataModel,callBack:(()->())){
        let context = kAppDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User_Data", in: context)
        let user = NSManagedObject(entity: entity!, insertInto: context)
        
        
        user.setValue(userData.device_id, forKey: "device_id")
        user.setValue(userData.access_token, forKey: "access_token")
        user.setValue(userData.device_token, forKey: "device_token")
        user.setValue(userData.device_type, forKey: "device_type")
        user.setValue(userData.email, forKey: "email")
        
        user.setValue(userData.first_name, forKey: "first_name")
        user.setValue(userData.full_name, forKey: "full_name")
        user.setValue(userData.id, forKey: "id")
        user.setValue(userData.last_name, forKey: "last_name")
        user.setValue(userData.latitude, forKey: "latitude")
        
        
        user.setValue(userData.longitude, forKey: "longitude")
        user.setValue(userData.picture, forKey: "picture")
        user.setValue(userData.rating, forKey: "rating")
        user.setValue(userData.rating_count, forKey: "rating_count")
        user.setValue(userData.social_unique_id, forKey: "social_unique_id")
        
        user.setValue(userData.mobile, forKey: "mobile")
        user.setValue(userData.stripe_cust_id, forKey: "stripe_cust_id")
        user.setValue(userData.wallet_balance, forKey: "wallet_balance")
        user.setValue(userData.login_by, forKey: "login_by")
        user.setValue(userData.status, forKey: "status")
        
        
        user.setValue(userData.parent_name, forKey: "parent_name")
        user.setValue(userData.dob, forKey: "dob")
        user.setValue(userData.gender, forKey: "gender")
        
        do {
            try context.save()
        } catch {
            print("Failed saving: - \(error)")
        }
        callBack()
    }
    
    //TODO: Get user model from api
    func getUserModelFromApi(responseDict:NSDictionary)->UserDataModel{
        
        var userData = UserDataModel(access_token: String(), device_id: String(), device_token: String(), device_type: String(), email: String(), first_name: String(), full_name: String(), id: String(), last_name: String(), latitude: String(), longitude: String(), picture: String(), rating: String(), rating_count: String(), social_unique_id: String(), mobile: String(), stripe_cust_id: String(), wallet_balance: String(), login_by: String(), status: String(),dob:String(), gender:String(), parent_name:String(),address_type:String(),house_no:String(),locality:String(),statename:String(),cityname:String(),pincode:String())
        
      
        
        if let access_token = responseDict.value(forKey: "access_token") as? String{
            userData.access_token =  access_token
        }
        
        if let device_id = responseDict.value(forKey: "device_id") as? String{
            userData.device_id =  device_id
        }
        
        if let device_token = responseDict.value(forKey: "device_token") as? String{
            userData.device_token =  device_token
        }
        
        if let device_type = responseDict.value(forKey: "device_type") as? String{
            userData.device_type =  device_type
        }
        
        if let email = responseDict.value(forKey: "email") as? String{
            userData.email =  email
        }
        
        if let first_name = responseDict.value(forKey: "first_name") as? String{
            userData.first_name =  first_name
        }
        
        if let full_name = responseDict.value(forKey: "full_name") as? String{
            userData.full_name =  full_name
        }
        
        if let id = responseDict.value(forKey: "id") as? String{
            userData.id =  id
        }
        
        if let id = responseDict.value(forKey: "id") as? Int{
            userData.id =  "\(id)"
        }
        
        if let user_id = responseDict.value(forKey: "user_id") as? String{
            userData.id =  user_id
        }
        
        if let user_id = responseDict.value(forKey: "user_id") as? Int{
            userData.id =  "\(user_id)"
        }
        
        
        if let last_name = responseDict.value(forKey: "last_name") as? String{
            userData.last_name =  last_name
        }
        
        if let latitude = responseDict.value(forKey: "latitude") as? String{
            userData.latitude =  latitude
        }
        
        if let longitude = responseDict.value(forKey: "longitude") as? String{
            userData.longitude =  longitude
        }
        
        if let picture = responseDict.value(forKey: "picture") as? String{
            userData.picture =  picture
        }
        
        if let rating = responseDict.value(forKey: "rating") as? String{
            userData.rating =  rating
        }
        
        if let rating = responseDict.value(forKey: "rating") as? Double{
            userData.rating =  "\(rating)"
        }
        
        if let rating = responseDict.value(forKey: "rating") as? Int{
            userData.rating =  "\(rating)"
        }
        
        if let rating_count = responseDict.value(forKey: "rating_count") as? String{
            userData.rating_count =  rating_count
        }
        
        if let rating_count = responseDict.value(forKey: "rating_count") as? Double{
            userData.rating_count =  "\(rating_count)"
        }
        
        if let rating_count = responseDict.value(forKey: "rating_count") as? Int{
            userData.rating_count =  "\(rating_count)"
        }
        
        
        if let social_unique_id = responseDict.value(forKey: "social_unique_id") as? String{
            userData.social_unique_id =  social_unique_id
        }
        
        if let mobile = responseDict.value(forKey: "mobile") as? String{
            userData.mobile =  mobile
        }
        
        if let status = responseDict.value(forKey: "status") as? String{
            userData.status =  status
        }
        
        
        if let stripe_cust_id = responseDict.value(forKey: "stripe_cust_id") as? String{
            userData.stripe_cust_id =  stripe_cust_id
        }
        
        
        if let wallet_balance = responseDict.value(forKey: "wallet_balance") as? String{
            userData.wallet_balance =  wallet_balance
        }
        
        if let wallet_balance = responseDict.value(forKey: "wallet_balance") as? Double{
            userData.wallet_balance =  "\(wallet_balance)"
        }
        
        if let wallet_balance = responseDict.value(forKey: "wallet_balance") as? Int{
            userData.wallet_balance =  "\(wallet_balance)"
        }
        
        if let login_by = responseDict.value(forKey: "login_by") as? String{
            userData.login_by =  login_by
        }
        
        if let parent_name = responseDict.value(forKey: "parent_name") as? String{
            userData.parent_name =  parent_name
        }
        
        if let dob = responseDict.value(forKey: "dob") as? String{
            userData.dob =  dob
        }
        
        if let gender = responseDict.value(forKey: "gender") as? String{
            userData.gender =  gender
            
        }
        
        
        if let address_type = responseDict.value(forKey: "address_type") as? String{
            userData.address_type =  address_type
            
        }
        
        if let house_no = responseDict.value(forKey: "house_no") as? String{
            userData.house_no =  house_no
            
        }
        
        if let locality = responseDict.value(forKey: "locality") as? String{
            userData.locality =  locality
            
        }
        
        if let cityname = responseDict.value(forKey: "cityname") as? String{
            userData.cityname =  cityname
            
        }
        
        if let statename = responseDict.value(forKey: "statename") as? String{
            userData.statename =  statename
            
        }
        
        if let pincode = responseDict.value(forKey: "pincode") as? String{
            userData.pincode =  pincode
            
        }
        
       
        return userData
    }
    
    
    
    //TODO: Check entity is empty
    func entityIsEmpty(entity: String) -> Bool{
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.count == 0{
                return true
            }else{
                return false
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
            return true
        }
        
    }
    
    
    
     
    //TODO: Delete all data
    func deleteAllData( entity:String,success: @escaping () -> ()) {
       
        let context = kAppDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try context.execute(request)
        } catch {
            print("Detele all data in \(entity) error :", error)
        }
        success()
    }
     
     
    
    //TODO: Get user from data base
    func getUser(entity: String) -> UserDataModel{
        
        var user = UserDataModel(access_token: String(), device_id: String(), device_token: String(), device_type: String(), email: String(), first_name: String(), full_name: String(), id: String(), last_name: String(), latitude: String(), longitude: String(), picture: String(), rating: String(), rating_count: String(), social_unique_id: String(), mobile: String(), stripe_cust_id: String(), wallet_balance: String(), login_by: String(), status: String(),dob:String(), gender:String(), parent_name:String(),address_type:String(),house_no:String(),locality:String(),statename:String(),cityname:String(),pincode:String())
        
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                user.access_token = data.value(forKey: "access_token") as? String ?? String()
                user.device_id = data.value(forKey: "device_id") as? String ?? String()
                user.device_token = data.value(forKey: "device_token") as? String ?? String()
                user.device_type = data.value(forKey: "device_type") as? String ?? String()
                user.email = data.value(forKey: "email") as? String ?? String()

                
                user.first_name = data.value(forKey: "first_name") as? String ?? String()
                user.full_name = data.value(forKey: "full_name") as? String ?? String()
                user.id = data.value(forKey: "id") as? String ?? String()
                user.last_name = data.value(forKey: "last_name") as? String ?? String()
                user.latitude = data.value(forKey: "latitude") as? String ?? String()

                
                user.longitude = data.value(forKey: "longitude") as? String ?? String()
                user.picture = data.value(forKey: "picture") as? String ?? String()
                user.rating = data.value(forKey: "rating") as? String ?? String()
                user.rating_count = data.value(forKey: "rating_count") as? String ?? String()
                user.social_unique_id = data.value(forKey: "social_unique_id") as? String ?? String()
                
                user.mobile = data.value(forKey: "mobile") as? String ?? String()
                user.stripe_cust_id = data.value(forKey: "stripe_cust_id") as? String ?? String()
                user.wallet_balance = data.value(forKey: "wallet_balance") as? String ?? String()
                user.login_by = data.value(forKey: "login_by") as? String ?? String()
                user.status = data.value(forKey: "status") as? String ?? String()
                
                
                
                user.parent_name = data.value(forKey: "parent_name") as? String ?? String()
                user.dob = data.value(forKey: "dob") as? String ?? String()
                user.gender = data.value(forKey: "gender") as? String ?? String()
                
                
                user.address_type = data.value(forKey: "address_type") as? String ?? String()
                user.house_no = data.value(forKey: "house_no") as? String ?? String()
                user.locality = data.value(forKey: "locality") as? String ?? String()
                
                
                user.statename = data.value(forKey: "statename") as? String ?? String()
                user.cityname = data.value(forKey: "cityname") as? String ?? String()
                user.pincode = data.value(forKey: "pincode") as? String ?? String()
                
               
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        return user
    }
    
    
    //TODO: Update status
    func updateStatus(id:String,status:String){
        
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User_Data")
        request.predicate = NSPredicate(format: "id = %@", id)
        do {
            let result = try context.fetch(request)
            if result.count > 0{
                let filterObject = result.first as! NSManagedObject
                filterObject.setValue(status, forKey: "status")
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
    
   
    

    
    
    //TODO: Call number
    func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
}


//MARK: - Extension for lottie animation
extension CustomMethodClass {
    
    //TODO: Run lottie animation
    func showLottieAnimation(_ view: UIView,_ animationName:String, _ loopMode:LottieLoopMode) {
        let animationViewLottie = AnimationView(name: animationName)
        view.isUserInteractionEnabled = false
        animationViewLottie.isHidden = false
        view.clipsToBounds = true
        animationViewLottie.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationViewLottie.contentMode = .scaleAspectFit
        animationViewLottie.animationSpeed = 1
        animationViewLottie.loopMode = loopMode
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
    
    
    
    //TODO: Run lottie animation
    func showLottieAnimationFill(_ view: UIView,_ animationName:String, _ loopMode:LottieLoopMode) {
        let animationViewLottie = AnimationView(name: animationName)
        view.isUserInteractionEnabled = false
        animationViewLottie.isHidden = false
        view.clipsToBounds = true
        animationViewLottie.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationViewLottie.contentMode = .scaleToFill
        animationViewLottie.animationSpeed = 1
        animationViewLottie.loopMode = loopMode
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
    
    
    //TODO: Setup error view
    func setupError(chidView:ErrorView,message:String,callback: @escaping () -> Void){
        chidView.backgroundColor = AppColor.clearColor
        chidView.viewLottie.backgroundColor = AppColor.clearColor
        chidView.lblDescription.backgroundColor = AppColor.clearColor
        
        chidView.lblDescription.font = AppFont.Bold.size(AppFontName.Montserrat, size: 18)
        chidView.lblDescription.textColor = AppColor.app_theame_color
        chidView.lblDescription.textAlignment = .center
        chidView.lblDescription.numberOfLines = 0
        chidView.lblDescription.text = message
        
        chidView.viewLottie.subviews.forEach({ $0.removeFromSuperview() }) // this gets things done
        _ = chidView.viewLottie.subviews.map({ $0.removeFromSuperview() }) // this returns modified array
        
        callback()
        
    }
    
    
    
    //TODO: Check subview is available or not
    func isSubviewAdded(parentView:UIView,childView:UIView) -> Bool{
        return childView.isDescendant(of: parentView) ? true : false
    }
    
    //TODO: Add subview
    func addSubView(parentView:UIView,childView:UIView){
        parentView.addSubview(childView)
    }
    
    
    //TODO: Remove subview
    func removeSubView(childView:UIView){
        childView.removeFromSuperview()
    }
    
    //TODO: Get animation name and message
    func getAnimationNameAndMessage(errorCode:Int)->(String,String){
        switch errorCode {
        case 1009:
            return (ConstantTexts.NoInternetConnectionEmptyState,ConstantTexts.noInterNet)
            
        case 400:
            return (ConstantTexts.Invalid_URLA,ConstantTexts.Invalid_URL)
            
        default:
            return (ConstantTexts.SomeThingWentWrong,ConstantTexts.somethingWentMessage)
        }
        
        
    }
    
    
}


