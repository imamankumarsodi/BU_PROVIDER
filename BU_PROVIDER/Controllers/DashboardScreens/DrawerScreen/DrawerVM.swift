//
//  DrawerVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/03/21.
//

import Foundation
import UIKit
class DrawerVM: CategoryListModeling {
    
    //TODO: Singleton object
    static let shared = DrawerVM()
    private init() {}
    
    //TODO: Prepare data source implementation
    func prepareDataSourceStatic() -> CategoryListViewModel {
        let categories = [Category(id: String(),image: #imageLiteral(resourceName: "repairing-service"), title: ConstantTexts.ServiceCat_LT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "history"), title: ConstantTexts.ServiceHistory_LT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "info"), title: ConstantTexts.Help_LT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "collaboration"), title: ConstantTexts.Share_LT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "logout"), title: ConstantTexts.LogOut_LT, Url: String(), isSelected: Bool())]
        
        return CategoryListViewModel(categories: categories)
    }
    
}
