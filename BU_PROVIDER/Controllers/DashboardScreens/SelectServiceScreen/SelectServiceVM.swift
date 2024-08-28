//
//  SelectServiceVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit
class SelectServiceVM: CategoryListModeling {
    
    //TODO: Singleton object
    static let shared = SelectServiceVM()
    private init() {}
    
    //TODO: Prepare data source implementation
    func prepareDataSourceStatic() -> CategoryListViewModel {
        let categories = [Category(id: String(),image: #imageLiteral(resourceName: "repairing-service"), title: ConstantTexts.BarberShopLT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "history"), title: ConstantTexts.HairDressingLT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "info"), title: ConstantTexts.MassagersLT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "collaboration"), title: ConstantTexts.BeautyNailsLT, Url: String(), isSelected: Bool()),
                          Category(id: String(),image: #imageLiteral(resourceName: "logout"), title: ConstantTexts.StylistLT, Url: String(), isSelected: Bool())]
        
        return CategoryListViewModel(categories: categories)
    }
    
}
