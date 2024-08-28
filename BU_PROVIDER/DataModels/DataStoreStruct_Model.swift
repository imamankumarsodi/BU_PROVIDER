//
//  DataStoreStruct_Model.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit

// MARK: - Login Struct
class DataStoreStruct{
    
    var title:String = String()
    var placeholder:String = String()
    var value:String = String()
    var type:SignUpType?
    //TODO: For custom methods
    init(title:String,placeholder:String,value:String,type:SignUpType) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.type = type
    }

}
