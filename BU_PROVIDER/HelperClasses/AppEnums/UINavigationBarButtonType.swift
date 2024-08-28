//
//  UINavigationBarButtonType.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
//MARK: - For UINavigationBarButtonType
enum UINavigationBarButtonType: Int {
    
    case back
    case backBlack
    case backRoot
    case empty
    case location
    case notification
    case menu
    case add
    
    //TODO : Set images according to UINavigationBarButtonType
    var iconImage: UIImage? {
        switch self {
        case .backRoot: return #imageLiteral(resourceName: "left-arrow")
        case .back: return #imageLiteral(resourceName: "left-arrow")
        case .backBlack: return #imageLiteral(resourceName: "left-arrow")
        case .location: return #imageLiteral(resourceName: "location")
        case .notification: return #imageLiteral(resourceName: "notification")
        case .menu: return #imageLiteral(resourceName: "menu")
        case .add: return #imageLiteral(resourceName: "plus")
        case .empty: return UIImage()
        }
    }
}
