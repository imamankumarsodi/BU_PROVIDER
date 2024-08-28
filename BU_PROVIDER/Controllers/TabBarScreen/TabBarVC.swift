//
//  TabBarVC.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import UIKit

class TabBarVC:UITabBarController {
    
    //MARK: - Variables
    
    private let images = [UIImage(systemName: "house.fill") , UIImage(systemName: "ellipsis")]
    private let titles = [ConstantTexts.HomeLT , ConstantTexts.MoreTitle]
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.extendedLayoutIncludesOpaqueBars = false
    }
    
}

//MARK: - Extension custom methods
extension TabBarVC{
    //TODO: Implementation setUpView
    private func setUpView() {
        self.tabBar.isTranslucent = true
        self.selectedIndex = 0
        self.delegate = self
        self.tabBar.unselectedItemTintColor = AppColor.whiteColor
        self.tabBar.barTintColor = AppColor.app_theame_color
        if let tabBarItems = tabBar.items{
            for index in 0..<tabBarItems.count {
                tabBarItems[index].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .selected)
                tabBarItems[index].imageInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                let image = images[index]?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.lightGray)
                tabBarItems[index].selectedImage = image
                tabBarItems[index].image = images[index]
                tabBarItems[index].title = titles[index]
            }
        }
    }
}


//MARK: - Tab Bar Delegate Method
extension TabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        return true
    }
    
    /*  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
     } */
}

