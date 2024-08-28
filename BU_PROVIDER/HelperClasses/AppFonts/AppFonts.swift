//
//  AppFonts.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit


//MARK: - Creating fonts
enum AppFontName: String {
    case Montserrat              =       "Montserrat"
}

enum AppFont: String {
   
    case Regular             =        "Regular"
    case Italic              =        "Italic"
    case Thin                =        "Thin"
    case ThinItalic          =        "ThinItalic"
    
    case ExtraLight          =        "ExtraLight"
    case ExtraLightItalic    =        "ExtraLightItalic"
    case Light               =        "Light"
    case LightItalic         =        "LightItalic"
    
    
    case Medium              =        "Medium"
    case MediumItalic        =        "MediumItalic"
    case SemiBold            =        "SemiBold"
    case SemiBoldItalic      =        "SemiBoldItalic"
    
    case Bold                =        "Bold"
    case BoldItalic          =        "BoldItalic"
    case ExtraBold           =        "ExtraBold"
    case ExtraBoldItalic     =        "ExtraBoldItalic"
    
    case Black               =        "Black"
    case BlackItalic         =        "BlackItalic"
   
    func size(_ name: AppFontName,size: CGFloat) -> UIFont {
        
        if let font = UIFont(name: self.fullFontName(name.rawValue), size: size + 1.0) {
            return font
        }
        fatalError("Font '\(String(describing: fullFontName))' does not exist.")
    }
    
    fileprivate func fullFontName(_ fontName:String) -> String {
        
            return rawValue.isEmpty ? fontName : fontName + "-" + rawValue
       
        
    }
}


