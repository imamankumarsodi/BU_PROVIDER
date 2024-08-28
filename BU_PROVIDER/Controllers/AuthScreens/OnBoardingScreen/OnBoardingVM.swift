//
//  OnBoardingVM.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 31/03/21.
//

import Foundation
class OnBoardingVM:OnBoardingModeling{
    
    //TODO: Singleton object
    static let shared = OnBoardingVM()
    private init() {}
    
    func prepareDataSourceStatic() -> OnboardingListViewModel {
        
        
        
        let array:[OnboardingDataModel] = [OnboardingDataModel(status: Bool(), title: ConstantTexts.identityProof_LT, serialNumber: ConstantTexts.one_LT),
                                           OnboardingDataModel(status: Bool(), title: ConstantTexts.personal_Details_LT, serialNumber: ConstantTexts.two_LT),
                                           OnboardingDataModel(status: Bool(), title: ConstantTexts.AddressTitle, serialNumber: ConstantTexts.three_LT),
                                           OnboardingDataModel(status: Bool(), title: ConstantTexts.declaration_LT, serialNumber: ConstantTexts.four_LT),
                                           OnboardingDataModel(status: Bool(), title: ConstantTexts.bankDetails_LT, serialNumber: ConstantTexts.five_LT)]
      return OnboardingListViewModel(array)
    }
}
