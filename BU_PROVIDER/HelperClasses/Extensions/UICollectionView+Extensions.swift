//
//  UICollectionView+Extensions.swift
//  Lawyer
//
//  Created by Aman Kumar on 02/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension UICollectionView {
    
    // Register nib on UITableView...
    func register(nib nibName:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    // Register multiple nib at once
    func registerMultiple(nibs arrayNibs:[String]) {
        for nibName in arrayNibs {
            register(nib: nibName)
        }
    }
}
