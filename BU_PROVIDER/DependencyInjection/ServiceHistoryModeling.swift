//
//  ServiceHistoryModeling.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
protocol ServiceHistoryModeling {
    
    //TODO: Prepare data source implementation
    func prepareDataSource(_ array:NSArray) -> ServiceHistoryListModel
}
