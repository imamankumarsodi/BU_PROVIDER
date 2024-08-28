//
//  StateCityDepnendencyInjection.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
protocol StateCityDepnendencyInjection {
    //TODO: Prepare data static source implementations
    func prepareDataSourceState(with array: NSArray) -> (StateCityListViewModel,[String])
    func prepareDataSourceCity(with array: NSArray) -> (StateCityListViewModel,[String])
    
}
