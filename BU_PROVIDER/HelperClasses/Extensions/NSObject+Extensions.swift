//
//  NSObject+Extensions.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
//MARK: - NSObject extension
extension NSObject {
    //TODO: Get class name
    class var className: String {
        return String(describing: self)
    }
}
