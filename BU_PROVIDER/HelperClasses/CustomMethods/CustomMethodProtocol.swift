//
//  CustomMethodProtocol.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
import Lottie
import DropDown
protocol CustomMethodProtocol {
    
    //TODO: Set url image on imageview
    func setImage(imageView:UIImageView,url:String)
    
    //TODO: Show ToolTip
    func showToolTip(msg:String,anchorView:UIView,sourceView:UIView)
    
    //TODO: Show ToolTip
    func showToolTipBottom(msg:String,anchorView:UIView,sourceView:UIView)
    
    //TODO: Provide corner radius
    func provideCornerRadiusTo(_ view:UIView, _ radius:CGFloat, _ corners:CACornerMask)
    
    //TODO: Provide shadow and corner radius
    func provideShadowAndCornerRadius(_ blueView:UIView, _ cornerRadius:CGFloat,_ corners:CACornerMask, _ shadowColor: UIColor, _ shadowWidth: CGFloat, _ shadowHeight: CGFloat,_ shadowOpacity: Float, _ shadowRadius: CGFloat, _ borderWidth:CGFloat, _ borderColor: UIColor)
    
    //TODO: Run lottie animation
    func showLottieAnimation(_ view: UIView,_ animationName:String, _ loopMode:LottieLoopMode)
    
    //TODO: Run lottie animation
    func showLottieAnimationFill(_ view: UIView,_ animationName:String, _ loopMode:LottieLoopMode)
    
    //TODO: Provide border
    func provideCornerBorderTo(_ item: UIView, _ border: CGFloat,_ borderColor: UIColor)
    
    //TODO: Provide AttributedText
    func provideSimpleAttributedText( text:String, font: UIFont,  color: UIColor)->NSMutableAttributedString
    
    //TODO: Provide underline AttributedText
    func provideUnderlineAttributedText( text:String, font: UIFont, _ color: UIColor)->NSMutableAttributedString
    
    //TODO: Open drop down
    func openDownOnView(dropDown:DropDown,array:[String],anchor:UIView,callBack:((_ dropDown:DropDown)->()))
    
    //TODO: Open drop down bottom direction
    func openDownOnViewBottomDirection(dropDown:DropDown,array:[String],anchor:UIView,callBack:((_ dropDown:DropDown)->()))
    
    //TODO: Get indexPath for tableview cell
    func getIndexPathFor(view: UIView, tableView: UITableView) -> IndexPath?
    
    //TODO: Get indexPath for collectionview cell
    func getIndexPathForCollectionView(view: UIView, collectionView: UICollectionView) -> IndexPath?
    
    //TODO: Get user model from api
    func getUserModelFromApi(responseDict:NSDictionary)->UserDataModel
    
    //TODO: Save data to local DB
    func saveDataToLocal_DB(userData:UserDataModel,callBack:(()->()))
    
    
    //TODO: Check entity is empty
    func entityIsEmpty(entity: String) -> Bool
    
    //TODO: Delete all data
    func deleteAllData(entity:String,success: @escaping () -> ())
    
    //TODO: Get user from data base
    func getUser(entity: String) -> UserDataModel
    
    
    func updateStatus(id:String,status:String)
    
    //TODO: Call number
    func callNumber(phoneNumber: String)
    
    //TODO: Setup error view
    func setupError(chidView:ErrorView,message:String,callback: @escaping () -> Void)
    
    
    //TODO: Check subview is available or not
    func isSubviewAdded(parentView:UIView,childView:UIView) -> Bool
    
    //TODO: Add subview
    func addSubView(parentView:UIView,childView:UIView)
    
    //TODO: Remove subview
    func removeSubView(childView:UIView)
    
    //TODO: Get animation name and message
    func getAnimationNameAndMessage(errorCode:Int)->(String,String)
    
    //TODO: Show alert simple
    func showAlert(_ message: String, okButtonTitle: String?, target: UIViewController?)
    
    
    //TODO: Show alert with cancel
    func showAlertWithCancel(title:String,message:String,btnOkTitle:String,btnCancelTitle:String,callBack:@escaping ((Bool)->()))
    
    //TODO: Show alert with cancel
    func showAlertWithOK(title:String,message:String,btnOkTitle:String,callBack:@escaping ((Bool)->()))
    
    
    //TODO - Get topmost view controller
    func topMostViewController(rootViewController: UIViewController) -> UIViewController?
    
    //TODO: Get root view controller
    func rootViewController() -> UIViewController
    
    
    
}
