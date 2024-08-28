//
//  CategoryDataModel.swift
//  BU
//
//  Created by Aman Kumar on 18/01/21.
//

import Foundation
import UIKit
struct Category {
    var id:String
    var image:UIImage
    var title:String
    var Url:String
    var isSelected:Bool
    
    mutating func togleIsSelected(value:Bool){
        self.isSelected = value
    }
    
   /* var ExpertiseId:String
    var Description:String */
}
