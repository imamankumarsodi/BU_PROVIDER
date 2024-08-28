//
//  ServiceListModeling.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
protocol ServiceListModeling {
    
    //TODO: Prepare data source implementation
    func prepareDataSource(_ array:NSArray) -> ServiceDataListModel
}
