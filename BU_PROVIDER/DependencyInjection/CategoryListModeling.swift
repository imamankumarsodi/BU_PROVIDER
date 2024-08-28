//
//  CategoryListModeling.swift
//  BU
//
//  Created by Aman Kumar on 18/01/21.
//

import Foundation
protocol CategoryListModeling {
    //TODO: Prepare data static source implementation
    func prepareDataSourceStatic() -> CategoryListViewModel
    func prepareDataSource(with array: NSArray) -> CategoryListViewModel
    
}

extension CategoryListModeling{
    func prepareDataSource(with array: NSArray) -> CategoryListViewModel{
        return CategoryListViewModel([Category]())
    }
}
