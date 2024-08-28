//
//  OnboardingViewModel.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 31/03/21.
//

import Foundation

struct OnboardingListViewModel {
    var onboardingDataList:[OnboardingDataModel]
}


extension OnboardingListViewModel{
    init(_ onboardingDataList:[OnboardingDataModel]) {
        self.onboardingDataList = onboardingDataList
    }
}


extension OnboardingListViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.onboardingDataList.count
    }
    
    
    public func dataStoreStructAtIndex(_ index:Int) -> OnboardingViewModel{
        return OnboardingViewModel(self.onboardingDataList[index])
    }
    
}








//TODO: Child view model for showing a single category
struct OnboardingViewModel {
    var onboardingData:OnboardingDataModel
}


extension OnboardingViewModel{
    init(_ onboardingData:OnboardingDataModel) {
        self.onboardingData = onboardingData
    }
}


extension OnboardingViewModel{
    
    var title:String{
        return self.onboardingData.title
    }
    
    var serialNumber:String{
        return self.onboardingData.serialNumber
    }
    
    var status:Bool{
        return self.onboardingData.status
    }
    
}
