//
//  BaseViewController.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//
import CoreLocation
import Foundation
import UIKit
class BaseViewController: UIViewController {
    
    //MARK: - Varibles for location
    internal var locationManager:CLLocationManager!
    internal var getLocationCallBack:((_ lat:CLLocationDegrees,_ long:CLLocationDegrees)->())?
    
    internal let myPickerController = UIImagePickerController()
    internal var getDocCallBack:((_ item : DocumentDataModel)->())?
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //TODO: Implementation touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismissKeyboard()
    }
    
    //MARK: - Actions, Selectors, Gestures
    //TODO:  selectors
    
    @objc func navigationButtonTapped(_ sender: AnyObject) {
        guard let buttonType = UINavigationBarButtonType(rawValue: sender.tag) else {
            return }
        
        switch buttonType {
        case .backRoot:
            print("do backRoot...")
            
        /*  let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
         vc.selectedIndex = 1
         UIApplication.shared.windows.first?.rootViewController = vc
         UIApplication.shared.windows.first?.makeKeyAndVisible() */
        
        case .back: self.navigationBarButtonDidTapped(buttonType)
        case .backBlack: self.navigationBarButtonDidTapped(buttonType)
        case .location: print("do nothing...")
        case .notification:
            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: NotificationVC.className) as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        case .add:
            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: ServiceDetailVC.className) as! ServiceDetailVC
            self.navigationController?.pushViewController(vc, animated: true)
            

        case .empty:
            print("do nothing...")
        case .menu:
            print("Open close drawer")
        }
    }
    
}
