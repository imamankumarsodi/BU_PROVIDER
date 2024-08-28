//
//  LoginVC+UITextFieldDelegate.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
import UIKit
//MARK: - UITextFieldDelegate extension
extension LoginVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndexPath = customMethodManager?.getIndexPathFor(view: textField, tableView: self.logInTable) else { return true }
        let lastRowIndex = self.logInTable.numberOfRows(inSection: 0) - 1
        if currentIndexPath.row != lastRowIndex {
            let nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            while nextIndexPath.row <= lastRowIndex {
                if let nextCell = self.logInTable.cellForRow(at: nextIndexPath) as? Auth_TextField_TableViewCell {
                    self.logInTable.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
                    nextCell.textFieldFloating?.returnKeyType = .next
                    if nextIndexPath.row == lastRowIndex {
                        nextCell.textFieldFloating?.returnKeyType = .done
                    }
                    nextCell.textFieldFloating?.becomeFirstResponder()
                    break
                }
            }
            textField.resignFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        let str = textField.text as String?
        if let index = customMethodManager?.getIndexPathFor(view: textField, tableView: self.logInTable) {
            if str?.count == 0 {
                
                self.dataListVM?.dataStoreStructAtIndex(index.row).dataStoreStruct.value = String()
            }
            else{
                self.dataListVM?.dataStoreStructAtIndex(index.row).dataStoreStruct.value = str ?? String()
            }
        }
    }
    
}
