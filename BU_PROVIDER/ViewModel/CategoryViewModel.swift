//
//  CategoryViewModel.swift
//  BU
//
//  Created by Aman Kumar on 18/01/21.
//

import Foundation
import UIKit


//TODO: Parent view model for showing list of category
struct CategoryListViewModel {
    
    var categories:[Category]
    
}

extension CategoryListViewModel{
    init(_ categories:[Category]) {
        self.categories = categories
    }
}

extension CategoryListViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.categories.count
    }
    
    
    public func categoryAtIndex(_ index:Int) -> CategoryViewModel{
        return CategoryViewModel(self.categories[index])
    }
    
}


//TODO: Child view model for showing a single category
struct CategoryViewModel {
    private let category:Category
}

extension CategoryViewModel{
    init(_ category:Category) {
        self.category = category
    }
}


extension CategoryViewModel{
    var title:String{
        return self.category.title
    }
    
   
    var Url:String{
        return self.category.Url
    }
    
    var image:UIImage{
        return self.category.image
    }
    
    var id:String{
        return self.category.id
    }
    
    var isSelected:Bool{
        return self.category.isSelected
    }
    
    
  /*  var Description:String{
        return self.category.Description
    }
    
    var expertiseId:String{
        return self.category.ExpertiseId
    } */
    
}
