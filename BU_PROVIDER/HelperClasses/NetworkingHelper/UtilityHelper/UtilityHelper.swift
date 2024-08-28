//
//  UtilityHelper.swift
//  BU
//
//  Created by Aman Kumar on 26/01/21.
//

import Foundation
import UIKit
class UtilityHelper {
    
    var container:UIView?
    var loadingView:UIView?
    var activityIndicator:UIActivityIndicatorView?
    var isVisible = false
    
    // MARK: - Set Up Application UI Appearance
    func getTopMostViewController() -> UIViewController {
        if var topController = KEY_WINDOW?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            return topController
        }
        return UIViewController()
    }
    
    class var sharedInstance: UtilityHelper {
        struct Static {
            static let instance  = UtilityHelper()
        }
        return Static.instance
    }
    
    func showActivityIndicator(color:UIColor) {
        DispatchQueue.main.async {
            if !self.isVisible {
                self.isVisible = true
                
                if self.container == nil{
                    self.container = UIView()
                }
                
                if self.loadingView == nil{
                    self.loadingView = UIView()
                }
                
                if self.activityIndicator == nil{
                    self.activityIndicator = UIActivityIndicatorView()
                }
                
                guard let container = self.container, let loadingView = self.loadingView,let activityIndicator = self.activityIndicator else {
                    return
                }
                
                container.bounds = (KEY_WINDOW?.bounds)!
                container.center =  (KEY_WINDOW?.center)!
                container.backgroundColor = UIColor.clear
                loadingView.frame = CGRect(x:0, y:0, width: 75, height: 75)
                loadingView.center =  (KEY_WINDOW?.center)!
                loadingView.backgroundColor = UIColor.clear
                loadingView.clipsToBounds = true
                loadingView.layer.cornerRadius = 10
                activityIndicator.backgroundColor = .lightGray
                activityIndicator.frame = CGRect(x:0, y:0, width: 75, height: 75)
                activityIndicator.style = UIActivityIndicatorView.Style.large
                activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2, y:loadingView.frame.size.height / 2)
                loadingView.addSubview(activityIndicator)
                container.addSubview(loadingView)
                activityIndicator.color = color
                KEY_WINDOW?.addSubview(container)
                activityIndicator.startAnimating()
            }
        }
    }
    
    
    func showActivityIndicatorWith(color:UIColor,view:UIView) {
       
        DispatchQueue.main.async {
            view.isUserInteractionEnabled = false
            if !self.isVisible {
                self.isVisible = true
                
                if self.container == nil{
                    self.container = UIView()
                }
                
                if self.loadingView == nil{
                    self.loadingView = UIView()
                }
                
                if self.activityIndicator == nil{
                    self.activityIndicator = UIActivityIndicatorView()
                }
                
                guard let container = self.container, let loadingView = self.loadingView,let activityIndicator = self.activityIndicator else {
                    return
                }
                
                container.bounds = (KEY_WINDOW?.bounds)!
                container.center =  (KEY_WINDOW?.center)!
                container.backgroundColor = UIColor.clear
                loadingView.frame = CGRect(x:0, y:0, width: 75, height: 75)
                loadingView.center =  (KEY_WINDOW?.center)!
                loadingView.backgroundColor = UIColor.clear
                loadingView.clipsToBounds = true
                loadingView.layer.cornerRadius = 10
                activityIndicator.backgroundColor = .lightGray
                activityIndicator.frame = CGRect(x:0, y:0, width: 75, height: 75)
                activityIndicator.style = UIActivityIndicatorView.Style.large
                activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2, y:loadingView.frame.size.height / 2)
                loadingView.addSubview(activityIndicator)
                container.addSubview(loadingView)
                activityIndicator.color = color
                KEY_WINDOW?.addSubview(container)
                activityIndicator.startAnimating()
            }
        }
    }
    
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.isVisible = false
            self.activityIndicator?.stopAnimating()
            self.container?.removeFromSuperview()
        }
    }
    
    func hideActivityIndicatorWith(view:UIView) {
        DispatchQueue.main.async {
            view.isUserInteractionEnabled = true
            self.isVisible = false
            self.activityIndicator?.stopAnimating()
            self.container?.removeFromSuperview()
        }
    }
}
